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
    user = Repo.one(from u in User, select: u, where: u.id == ^id)
    if user == nil do
      Logger.error("le user n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      put_status(conn, 200)
      |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
    end
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
      end,

      Address: swagger_schema do
        title "Address"
        description "Address descr"
        properties do
          name :string, "Name"
          first_line :string, "First line"
          second_line :string, "Second line"
          post_code :string, "Post code"
          town :string, "Town"
          recipient :string, "Recipient"
          country :string, "Country"
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

  # create address to user
  swagger_path :createAddress do
    post("/users/address/{id}")
    summary("Create address")
    description("Create a new address")
    produces "application/json"
    parameter :id, :path, :integer, "The id of the address to be updated", required: true
    parameter :address, :body, Schema.ref(:Address), "Address", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Maison",
      first_line: "8 rue de la gare",
      second_line: "",
      post_code: "75009",
      town: "Paris",
      recipient: "M John Doe",
      country: "France"
    })
  end

  def createAddress(conn, params) do
    id = params["id"]
    name = params["name"]
    first_line = params["first_line"]
    second_line = params["second_line"] || nil
    post_code = params["post_code"]
    town = params["town"]
    recipient = params["recipient"]
    country = params["country"]

    user = Repo.one(from u in User, select: u, where: u.id == ^id)
    if user == nil do
      Logger.error("l'addresse n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      IO.inspect(recipient)
      case Repo.insert %User.Address{name: name, first_line: first_line, second_line: second_line, post_code: post_code, town: town, country: country, recipient: recipient, user_id: user.id} do
        {:ok, user_address} ->
          put_status(conn, 201)
          |> KiraBijouxWeb.UserAddressView.render("index.json", %{user_address: user_address})
        {:error, changeset} ->
          Logger.error changeset
          put_status(conn, 500)
      end
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
    id = params["id"]
    firstname = params["firstname"]
    lastname = params["lastname"]
    mail = params["mail"]
    phone = params["phone"]
    password = params["password"]
    |> Bcrypt.hash_pwd_salt()

    user = Repo.one(from u in User, select: u, where: u.id == ^id)
    if user == nil do
      Logger.error("le user n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      case Repo.update User.changeset(user, %{firstname: firstname, lastname: lastname, phone: phone, mail: mail, password: password}) do
        {:ok, user} ->
          put_status(conn, 200)
          |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
        {:error, changeset} ->
          Logger.error changeset
          put_status(conn, 500)
      end
    end
  end

  # update address to user
  swagger_path :updateAddress do
    put("/users/address/{id}")
    summary("Update address")
    description("Update an existing address")
    produces "application/json"
    parameter :id, :path, :integer, "The id of the address to be updated", required: true
    parameter :address, :body, Schema.ref(:Address), "Address", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Maison",
      first_line: "9 rue de la gare",
      second_line: "",
      post_code: "75006",
      town: "Paris",
      recipient: "M Johno Doe",
      country: "France"
    })
  end

  def updateAddress(conn, params) do
    id = params["id"]
    name = params["name"]
    first_line = params["first_line"]
    second_line = params["second_line"] || nil
    post_code = params["post_code"]
    town = params["town"]
    recipient = params["recipient"]
    country = params["country"]

    user_address = Repo.one(from u in User.Address, select: u, where: u.user_id == ^id)
    if user_address == nil do
      Logger.error("l'addresse n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      case Repo.update User.Address.changeset(user_address, %{name: name, first_line: first_line, second_line: second_line, post_code: post_code, town: town, recipient: recipient, country: country}) do
        {:ok, user_address} ->
          put_status(conn, 201)
          |> KiraBijouxWeb.UserAddressView.render("index.json", %{user_address: user_address})
        {:error, changeset} ->
          Logger.error changeset
          put_status(conn, 500)
      end
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
    user = Repo.one(from u in User, select: u, where: u.id == ^id)
    if user == nil do
      Logger.error("le user n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      Repo.delete(user)
      put_status(conn, 200)
      |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
    end
  end

  # delete address of user
  swagger_path(:deleteAddress) do
    PhoenixSwagger.Path.delete("/users/address/{id}")
    summary("Delete Address")
    description("Delete a address by id")
    parameter :id, :path, :integer, "The id of the address to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def deleteAddress(conn, %{"id" => id}) do
    user_address = Repo.one(from u in User.Address, select: u, where: u.user_id == ^id)
    if user_address == nil do
      Logger.error("l'adresse n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      Repo.delete(user_address)
      put_status(conn, 200)
      |> KiraBijouxWeb.UserAddressView.render("index.json", %{user_address: user_address})
    end
  end
end
