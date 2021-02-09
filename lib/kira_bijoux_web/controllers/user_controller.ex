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


  # create user
  swagger_path :create do
    post("/users")
    summary("Create user")
    description("Create a new user")
    produces "application/json"
    parameters do
      firstname :query, :string, "The firstname of the user to be created", required: true
      lastname :query, :string, "The lastname of the user to be created", required: true
      mail :query, :string, "The mail of the user to be created", required: true
      password :query, :string, "The password of the user to be created", required: true
      phone :query, :string, "The phone of the user to be created", required: false
    end
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
    parameters do
      mail :query, :string, "The mail of the user to be updated", required: true
    end
  end

  def update(conn, %{"id" => id, "mail" => mail}) do
    user = Repo.get!(User, id)
    |> KiraBijoux.User.changeset(%{mail: mail})
    case Repo.update user do
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
