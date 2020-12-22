defmodule KiraBijouxWeb.AuthController do
  import Plug.Conn.Status, only: [code: 1]
  use KiraBijouxWeb, :controller
  use PhoenixSwagger

  # import Ecto.Query, warn: false
  # alias KiraBijouxWeb.Repo
  # alias KiraBijouxWeb.User


  # get session
  swagger_path :get_session do
    get("/users")
    summary("Get all users")
    description("List of users")
    response(code(:ok), "Success")
  end

  def get_session(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    text conn, user_id
    IO.inspect(user_id: "session")
    IO.inspect(conn: "connexion")
    if user_id, do: !!Repo.get(Teacher.Accounts.User, user_id)
  end

  # registration
  swagger_path :register do
    post("/users")
    summary("Create user")
    description("Create a new user")
    produces "application/json"
    parameters do
      firstname :query, :string, "The firstname of the user to be created", required: true
      lastname :query, :string, "The lastname of the user to be created", required: true
      mail :query, :string, "The mail of the user to be created", required: true
      password :query, :string, "The password of the user to be created", required: true
    end
  end

  def register(conn, params) do
    firstname = params["firstname"]
    lastname = params["lastname"]
    mail = params["mail"]
    password = params["password"]
    password = Comeonin.Bcrypt.hashpwsalt(password)
    case Repo.insert %User{firstname: firstname, lastname: lastname, mail: mail, password: password, user_role_id: 1} do
      {:ok, user} ->
        put_status(conn, 201)
        |> put_session(:current_user_id, user.id)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end


  # connexion
  swagger_path :connect do
    post("/users")
    summary("Create user")
    description("Create a new user")
    produces "application/json"
    parameters do
      mail :query, :string, "The mail of the user to be created", required: true
      password :query, :string, "The password of the user to be created", required: true
    end
  end

  def connect(conn, params) do
    mail = params["mail"]
    password = params["password"]
    user = Repo.get_by(User, mail: mail)
    IO.inspect(user.id)
    case Comeonin.Bcrypt.check_pass(user, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        conn
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # deconnexion
  swagger_path(:logout) do
    PhoenixSwagger.Path.delete("/users/{id}")
    summary("Delete User")
    description("Delete a user by id")
    parameter :id, :path, :integer, "The id of the user to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:current_user_id)
  end
end
