defmodule KiraBijouxWeb.AuthController do
  import Plug.Conn.Status, only: [code: 1]
  use KiraBijouxWeb, :controller
  use PhoenixSwagger
  alias KiraBijoux.Accounts

  # get session
  swagger_path :get_session do
    get("/auth/session")
    summary("Get user session")
    description("user session")
    response(code(:ok), "Success")
  end

  def get_session(conn, _params) do
    text conn, :current_user_id
    if res == true do
      Logger.info "connexion réussi"
      put_status(conn, 201)
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    Logger.info user_id
    if user_id, do: !!Repo.get(User, user_id)
  end

  # registration
  swagger_path :register do
    post("/auth/registration")
    summary("Register user")
    description("Register a new user")
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
    password = Bcrypt.hash_pwd_salt(password)
    case Repo.insert %User{firstname: firstname, lastname: lastname, mail: mail, password: password, user_role_id: 1} do
      {:ok, user} ->
        put_status(conn, 201)
        |> fetch_session
        |> put_session(:current_user_id, user.id)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end


  # connexion
  swagger_path :connect do
    post("/auth/connexion")
    summary("Connect user")
    description("Connect a new user")
    produces "application/json"
    parameters do
      mail :query, :string, "The mail of the user to be created", required: true
      password :query, :string, "The password of the user to be created", required: true
    end
    response(203, "No Content - Deleted Successfully")
  end

  def connect(conn, params) do
    mail = params["mail"]
    password = params["password"]
    user = Accounts.get_by_email(mail)
    hash = user.password
    res = Bcrypt.verify_pass(password, hash)
    Logger.info conn

    if res == true do
      Logger.info "connexion réussi"
      put_status(conn, 201)
      |> fetch_session
      |> put_session(:current_user_id, user.id)
      |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
    else
      Logger.error "Adresse mail/mot de passe incorrect"
      put_status(conn, 500)
    end
  end

  # deconnexion
  swagger_path(:logout) do
    PhoenixSwagger.Path.delete("/auth/deconnexion")
    summary("Destroy user session")
    description("user session")
    response(203, "No Content - Deleted Successfully")
  end

  def logout(conn) do
    conn
    |> delete_session(:current_user_id)
  end
end
