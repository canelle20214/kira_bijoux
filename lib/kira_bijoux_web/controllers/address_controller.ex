defmodule KiraBijouxWeb.AddressController do
  use KiraBijouxWeb, :controller

  # get address by id
  swagger_path :show do
    get("/addresses/{id}")
    summary("Get address by id")
    description("Address filtered by id")
    parameter :id, :path, :integer, "The id of the address to be display", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(User.Address, id) do
      nil ->
        Logger.error "L'adresse n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      address ->
        put_status(conn, 200)
        |> UserAddressView.render("index.json", %{address: address})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get addresses by user
  swagger_path :showByUserId do
    get("/addresses/{id}")
    summary("Get address by user")
    description("Address filtered by user")
    parameter :id, :path, :integer, "The id of the user to be display", required: true
    response(code(:ok), "Success")
  end

  def showByUserId(conn, %{"id" => id}) do
    case Repo.all(from ua in User.Address, select: ua, where: ua.id == ^id) do
      [] ->
        Logger.error "Aucune adresse ne correspond à cet utilisateur."
        put_status(conn, 404)
        |> json("Not found")
      addresses ->
        put_status(conn, 200)
        |> UserAddressView.render("index.json", %{addresses: addresses})
    end
  end
  def showByUserId(conn, _), do: put_status(conn, 400) |> json("Bad request")

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
    post("/addresses/{id}")
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
    produces "application/json"
    response(201, "Created", Schema.ref(:Address),
      example:
        %{
          user_id: 1,
          name: "Maison",
          first_line: "8 rue de la gare",
          second_line: "",
          post_code: "75009",
          town: "Paris",
          recipient: "M John Doe",
          country: "France"
        }
    )
  end

  def create(conn, %{"id" => user_id, "name" => name, "recipient" => recipient, "first_line" => first_line, "second_line" => second_line, "post_code" => post_code, "town" => town, "country" => country}) do
    case Repo.insert %User.Address{user_id: user_id, name: name, first_line: first_line, second_line: second_line, post_code: post_code, town: town, country: country, recipient: recipient} do
      {:ok, user_address} ->
        put_status(conn, 201)
        |> UserAddressView.render("index.json", %{user_address: user_address})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, %{"id" => user_id, "name" => name, "recipient" => recipient, "first_line" => first_line, "post_code" => post_code, "town" => town, "country" => country}) do
    case Repo.insert %User.Address{user_id: user_id, name: name, first_line: first_line, post_code: post_code, town: town, country: country, recipient: recipient} do
      {:ok, user_address} ->
        put_status(conn, 201)
        |> UserAddressView.render("index.json", %{user_address: user_address})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # update address to user
  swagger_path :update do
    put("/addresses/{id}")
    summary("Update address")
    description("Update an existing address")
    produces "application/json"
    parameter :id, :path, :integer, "The id of the address to be updated", required: true
    parameter :address, :body, Schema.ref(:Address), "Address", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      user_id: 1,
      name: "Maison",
      first_line: "9 rue de la gare",
      second_line: "",
      post_code: "75006",
      town: "Paris",
      recipient: "M John Doe",
      country: "France"
    })
    produces "application/json"
    response(200, "OK", Schema.ref(:Address),
      example:
        %{
          user_id: 1,
          name: "Maison",
          first_line: "9 rue de la gare",
          second_line: "",
          post_code: "75006",
          town: "Paris",
          recipient: "M John Doe",
          country: "France"
        }
    )
  end

  def update(conn, %{"id" => id} = params) do
    case Repo.get(User.Address, id) do
      nil ->
        Logger.error "L'adresse n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      address ->
        user_id = params["user_id"] || address.user_id
        name = params["name"] || address.name
        first_line = params["first_line"] || address.first_line
        second_line = params["second_line"] || nil
        post_code = params["post_code"] || address.post_code
        town = params["town"] || address.town
        recipient = params["recipient"] || address.recipient
        country = params["country"] || address.country
        case Repo.update User.Address.changeset(address, %{user_id: user_id, name: name, first_line: first_line, second_line: second_line, post_code: post_code, town: town, recipient: recipient, country: country}) do
          {:ok, user_address} ->
            put_status(conn, 201)
            |> UserAddressView.render("index.json", %{user_address: user_address})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete address of user
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/addresses/{id}")
    summary("Delete Address")
    description("Delete a address by id")
    parameter :id, :path, :integer, "The id of the address to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with user_address = %User.Address{} <- Repo.one(from ua in User.Address, select: ua, where: ua.id == ^id),
    {:ok, _} <- Repo.delete user_address do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      nil ->
        Logger.error "L'adresse n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
