defmodule KiraBijouxWeb.UserController do
  import Plug.Conn.Status, only: [code: 1]
  use KiraBijouxWeb, :controller
  use PhoenixSwagger

  # get all users
  swagger_path :index do
    get("/users")
    summary("Get all users")
    description("List of users")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
    users = Repo.all(from u in User, select: u)
    put_status(conn, 200)
    |> KiraBijouxWeb.UserView.render("index.json", %{users: users})
  end


  # get user by id
  swagger_path :show do
    get("/users/{id}")
    summary("Get user by id")
    description("User filtered by id")
    parameter :id, :path, :integer, "The id of the user to be display", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    put_status(conn, 200)
    |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
  end

  def swagger_definitions do
    %{
      User: swagger_schema do
        title "User"
        description "User descr"
        properties do
          firstname :string, "Firstname"
          lastname :string, "Lastname"
          mail :string, "Mail"
          password :string, "Password"
          phone :string, "Phone"
        end
      end
    }
  end

  # create user
  swagger_path :create do
    post("/users")
    summary("Create user")
    description("Create a new user")
    produces "application/json"
    parameter :user, :body, Schema.ref(:User), "User", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      firstname: "John",
      lastname: "Doe",
      mail: "john.doe@gmail.com",
      password: "1234",
      phone: "0643239066"
    })
  end

  def create(conn, params) do
    firstname = params["firstname"]
    lastname = params["lastname"]
    mail = params["mail"]
    phone = params["phone"] || nil
    password = params["password"]
    |> Bcrypt.hash_pwd_salt()
    case Repo.insert %User{firstname: firstname, lastname: lastname, phone: phone, mail: mail, password: password, user_role_id: 1} do
      {:ok, user} ->
        put_status(conn, 201)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end


  # update user
  swagger_path :update do
    put("/users/{id}")
    summary("Update user")
    description("Update an existing user")
    produces "application/json"
    parameter :id, :path, :integer, "The id of the user to be updated", required: true
    parameter :user, :body, Schema.ref(:User), "User", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      firstname: "Johno",
      lastname: "Doeno",
      mail: "johno.doeno@gmail.com",
      password: "12345",
      phone: "0643239067"
    })
  end

  def update(conn, params) do
    user = Repo.get!(User, params["id"])
    firstname = params["firstname"]
    lastname = params["lastname"]
    mail = params["mail"]
    phone = params["phone"]
    password = params["password"]
    |> Bcrypt.hash_pwd_salt()

    case Repo.update User.changeset(user, %{firstname: firstname, lastname: lastname, phone: phone, mail: mail, password: password}) do
      {:ok, user} ->
        put_status(conn, 200)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end


  # delete user
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/users/{id}")
    summary("Delete User")
    description("Delete a user by id")
    parameter :id, :path, :integer, "The id of the user to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    case Repo.delete user do
      {:ok, user} ->
        put_status(conn, 200)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
