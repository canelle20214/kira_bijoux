defmodule KiraBijouxWeb.AuthController do
  import Plug.Conn.Status, only: [code: 1]
  use KiraBijouxWeb, :controller
  use PhoenixSwagger
  alias KiraBijoux.Accounts

  def swagger_definitions do
    %{
      Auth: swagger_schema do
        title "Auth"
        description "Auth descr"
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

  # registration
  swagger_path :register do
    post("/auth/registration")
    summary("Register user")
    description("Register a new user")
    produces "application/json"
    parameter :auth, :body, Schema.ref(:Auth), "Auth", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      firstname: "John",
      lastname: "Doe",
      mail: "john.doe@gmail.com",
      password: "1234",
      phone: "0643239066"
    })
  end

  def register(conn, params) do
    firstname = params["firstname"]
    lastname = params["lastname"]
    mail = params["mail"]
    password = params["password"]
    |> Bcrypt.hash_pwd_salt()

    emailExists = Repo.exists?(from u in User, where: u.mail == ^mail)
    if emailExists == true do
      Logger.error("l'email existe déjà")
      put_status(conn, 500)
    else
      case Repo.insert(%User{
            firstname: firstname,
            lastname: lastname,
            mail: mail,
            password: password,
            user_role_id: 1
          }) do
        {:ok, user} ->
          Logger.info("successful registration")
          put_status(conn, 201)
          |> KiraBijouxWeb.UserView.render("index.json", %{user: user})

        {:error, changeset} ->
          Logger.error(changeset)
          put_status(conn, 500)
      end
    end
  end

  # connection
  swagger_path :connect do
    post("/auth/connexion")
    summary("Connect user")
    description("Connect a new user")
    produces "application/json"
    parameter :auth, :body, Schema.ref(:Auth), "Auth", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      mail: "john.doe@gmail.com",
      password: "1234",
    })
  end

  def connect(conn, params) do
    mail = params["mail"]
    password = params["password"]
    user = Accounts.get_by_email(mail)
    hash = user.password
    res = Bcrypt.verify_pass(password, hash)

    if res == true do
      Logger.info("successful connection")
      put_status(conn, 201)
      |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
    else
      Logger.error("Adresse mail/mot de passe incorrect")
      put_status(conn, 500)
    end
  end
end
