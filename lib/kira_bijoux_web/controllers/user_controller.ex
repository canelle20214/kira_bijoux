defmodule KiraBijouxWeb.UserController do
  use KiraBijouxWeb, :controller

  # get all users
  swagger_path :index do
    get("/users")
    summary("Get all users")
    description("List of users")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
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
    user = Repo.one(from u in User, select: u, where: u.id == ^id)
    if user == nil do
      Logger.error("le user n'existe pas")
      put_status(conn, 404)
      |> json("Not found")
    else
      put_status(conn, 200)
      |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

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
    produces "application/json"
    response(201, "Created", Schema.ref(:User),
      example:
      %{
        firstname: "John",
        lastname: "Doe",
        mail: "john.doe@gmail.com",
        password: "1234",
        phone: "0643239066"
      }
    )
  end

  def create(conn, %{"firstname" => firstname, "lastname" => lastname, "mail" => mail, "phone" => phone, "password" => password}) do
    case Repo.insert %User{firstname: firstname, lastname: lastname, phone: phone, mail: mail, password: Bcrypt.hash_pwd_salt(password), user_role_id: 1} do
      {:ok, user} ->
        put_status(conn, 201)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, %{"firstname" => firstname, "lastname" => lastname, "mail" => mail, "password" => password}) do
    case Repo.insert %User{firstname: firstname, lastname: lastname, mail: mail, password: Bcrypt.hash_pwd_salt(password), user_role_id: 1} do
      {:ok, user} ->
        put_status(conn, 201)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

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
    produces "application/json"
    response(200, "OK", Schema.ref(:User),
      example:
      %{
        firstname: "John",
        lastname: "Doe",
        mail: "john.doe@gmail.com",
        password: "1234",
        phone: "0643239066"
      }
    )
  end

  def update(conn, %{"id" => id} = params) do
    case Repo.one(from u in User, select: u, where: u.id == ^id) do
      nil ->
        Logger.error "Le user n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      user ->
        firstname = params["firstname"] || user.firstname
        lastname = params["lastname"] || user.firstname
        mail = params["mail"] || user.firstname
        phone = params["phone"] || user.firstname
        password = case params["password"] do
          nil ->
            user.password
          password ->
            Bcrypt.hash_pwd_salt(password)
        end
        case Repo.update User.changeset(user, %{firstname: firstname, lastname: lastname, phone: phone, mail: mail, password: password}) do
          {:ok, user} ->
            put_status(conn, 200)
            |> UserView.render("index.json", %{user: user})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete user
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/users/{id}")
    summary("Delete User")
    description("Delete a user by id")
    parameter :id, :path, :integer, "The id of the user to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with user = %User{} <- Repo.one(from u in User, select: u, where: u.id == ^id),
    {:ok, _} <- Repo.delete user do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      nil ->
        Logger.error "Le user n'existe pas"
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
