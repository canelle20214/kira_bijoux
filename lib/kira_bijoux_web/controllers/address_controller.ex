defmodule KiraBijouxWeb.AddressController do
  use KiraBijouxWeb, :controller

  # get address by user
  swagger_path :show do
    get("/address/{id}")
    summary("Get address by user")
    description("Address filtered by user")
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
      Address: swagger_schema do
        title "Address"
        description "Address descr"
        properties do
          user_id :integer, "User id"
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

  # create address to user
  swagger_path :create do
    post("/address/{id}")
    summary("Create address")
    description("Create a new address")
    produces "application/json"
    parameter :id, :path, :integer, "The id of the user who want add address", required: true
    parameter :address, :body, Schema.ref(:Address), "Address", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      user_id: 1,
      name: "Maison",
      first_line: "8 rue de la gare",
      second_line: "",
      post_code: "75009",
      town: "Paris",
      recipient: "M John Doe",
      country: "France"
    })
  end

  def create(conn, params) do
    user_id = params["user_id"]
    name = params["name"]
    first_line = params["first_line"]
    second_line = params["second_line"] || nil
    post_code = params["post_code"]
    town = params["town"]
    recipient = params["recipient"]
    country = params["country"]

      case Repo.insert %User.Address{user_id: user_id, name: name, first_line: first_line, second_line: second_line, post_code: post_code, town: town, country: country, recipient: recipient} do
        {:ok, user_address} ->
          put_status(conn, 201)
          |> KiraBijouxWeb.UserAddressView.render("index.json", %{user_address: user_address})
        {:error, changeset} ->
          Logger.error changeset
          put_status(conn, 500)
      end
  end

  # update address to user
  swagger_path :update do
    put("/address/{user_id}/{address_id}")
    summary("Update address")
    description("Update an existing address")
    produces "application/json"
    parameter :user_id, :path, :integer, "The id of the user to be updated", required: true
    parameters do
      address_id :path, :integer, "The id of the address to be updated", required: true
    end
    parameter :address, :body, Schema.ref(:Address), "Address", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      user_id: 1,
      name: "Maison",
      first_line: "9 rue de la gare",
      second_line: "",
      post_code: "75006",
      town: "Paris",
      recipient: "M Johno Doe",
      country: "France"
    })
  end

  def update(conn, params) do
    address = Repo.get!(Address, params["id"])
    address_id = params["address_id"]
    user_id = params["user_id"] || address.user_id
    name = params["name"]
    first_line = params["first_line"]
    second_line = params["second_line"] || nil
    post_code = params["post_code"]
    town = params["town"]
    recipient = params["recipient"]
    country = params["country"]

    user_address = Repo.one(from u in User.Address, select: u, where: u.id == ^address_id and u.user_id == ^user_id)
    if user_address == nil do
      Logger.error("le user ou l'addresse n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      case Repo.update User.Address.changeset(user_address, %{user_id: user_id, name: name, first_line: first_line, second_line: second_line, post_code: post_code, town: town, recipient: recipient, country: country}) do
        {:ok, user_address} ->
          put_status(conn, 201)
          |> KiraBijouxWeb.UserAddressView.render("index.json", %{user_address: user_address})
        {:error, changeset} ->
          Logger.error changeset
          put_status(conn, 500)
      end
    end
  end

  # delete address of user
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/address/{id}")
    summary("Delete Address")
    description("Delete a address by id")
    parameter :id, :path, :integer, "The id of the address to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    user_address = Repo.one(from u in User.Address, select: u, where: u.id == ^id)
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
