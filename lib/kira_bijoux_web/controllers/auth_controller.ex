defmodule KiraBijouxWeb.AuthController do
  use KiraBijouxWeb, :controller
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
    produces "application/json"
    response(201, "Created", Schema.ref(:Auth),
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

  def register(conn, %{"firstname" => firstname, "lastname" => lastname, "mail" => mail, "password" => password}) do
    if String.length(password) < 8 do
      Logger.error "le mot de passe doit comporter au moins 8 characteres"
      put_status(conn, 400)
      |> json("Bad request")
      exit(:shutdown)
    end
    with false <- Repo.exists?(from u in User, where: u.mail == ^mail),
    {:ok, user} <- Repo.insert(%User{
      firstname: firstname,
      lastname: lastname,
      mail: mail,
      password: Bcrypt.hash_pwd_salt(password),
      user_role_id: 1
    }) do
      Logger.info "Inscription terminée !"
      put_status(conn, 201)
      |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
    else
      true ->
        Logger.error "L'adresse mail existe déjà."
        put_status(conn, 400)
        |> json("Bad request")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def register(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # connection
  swagger_path :connect do
    post("/auth/connexion")
    summary("Connect user")
    description("Connect a new user")
    parameter :auth, :body, Schema.ref(:Auth), "Auth", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      mail: "john.doe@gmail.com",
      password: "1234"
    })
    produces "application/json"
    response(200, "OK", Schema.ref(:Auth),
      example:
        %{
          mail: "john.doe@gmail.com",
          password: "1234"
        }
    )
  end

  def connect(conn, %{"mail" => mail, "password" => password}) do
    with user = %User{} <- Accounts.get_by_email(mail),
    true <- Bcrypt.verify_pass(password, user.password) do
      Logger.info "Connexion effectuée"
      put_status(conn, 201)
      |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
    else
      nil ->
        Logger.info "L'adresse mail n'est associée à aucun compte."
        put_status(conn, 404)
        |> json("Not found")
      _ ->
        Logger.error "Adresse mail/mot de passe incorrect"
        put_status(conn, 500)
    end
  end
  def connect(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
