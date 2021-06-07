defmodule KiraBijouxWeb.ItemParentController do
  use KiraBijouxWeb, :controller

  # get all item parents
  swagger_path :index do
    get("/item-parents")
    summary("Get all item parents")
    description("List of item parents")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
    item_parents = Repo.all(from p in Item.Parent, select: p)
    put_status(conn, 200)
    |> ItemParentView.render("index.json", %{item_parents: item_parents})
  end

  def swagger_definitions do
    %{
      Item_Parent: swagger_schema do
        title "Item.Parents"
        description "Item.Parents descr"
        properties do
          collection_id :integer, "Collection id"
          item_type_id :integer, "Type id"
          name :integer, "Name"
        end
      end
    }
  end

  # get item parent by id
  swagger_path :show do
    get("/item-parents/{id}")
    summary("Get item parents by id")
    description("Item.Parents filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.one(from p in Item.Parent, select: p, where: p.id == ^id) do
      nil ->
        Logger.error("la catégorie d'item n'existe pas")
        put_status(conn, 404)
        |> json([])
      item_parent ->
        put_status(conn, 200)
        |> ItemParentView.render("index.json", %{item_parent: item_parent})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get item parent by type
  swagger_path :showByType do
    get("/item-parents/type/{id}")
    summary("Get item parents by type id")
    description("Item.Parents filtered by type id")
    parameter :id, :path, :integer, "Id of type of the item parents to be displayed", required: true
    response(code(:ok), "Success")
  end

  def showByType(conn, %{"id" => id}) do
    case Repo.all(from p in Item.Parent, select: p, where: p.item_type_id == ^id) do
      [] ->
        Logger.error("le type de catégorie d'item n'existe pas")
        put_status(conn, 404)
        |> json([])
      item_parents ->
        put_status(conn, 200)
        |> ItemParentView.render("index.json", %{item_parents: item_parents})
    end
  end
  def showByType(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get item parent by collection
  swagger_path :showByCollection do
    get("/item-parents/collection/{id}")
    summary("Get item parents by collection id")
    description("Item.Parents filtered by collection id")
    parameter :id, :path, :integer, "Id of collection of the item parents to be displayed", required: true
    response(code(:ok), "Success")
  end

  def showByCollection(conn, %{"id" => id}) do
    case Repo.all(from p in Item.Parent, select: p, where: p.collection_id == ^id) do
      [] ->
        Logger.error("la collection de catégorie d'item n'existe pas")
        put_status(conn, 404)
        |> json([])
      item_parents ->
        put_status(conn, 200)
        |> ItemParentView.render("index.json", %{item_parents: item_parents})
    end
  end
  def showByCollection(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # create item parent
  swagger_path :create do
    post("/item-parents")
    summary("Create Item Parent")
    description("Create a new Item.Parent")
    produces "application/json"
    parameter :item_parent, :body, Schema.ref(:Item_Parent), "Item_Parent", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      collection_id: 1,
      item_type_id: 1,
      name: "Test"
    })
  end

  def create(conn, %{"collection_id" => collection_id, "item_type_id" => item_type_id, "name" => name}) do
    case Repo.insert %Item.Parent{collection_id: collection_id, item_type_id: item_type_id, name: name} do
      {:ok, item_parent} ->
        put_status(conn, 201)
        |> ItemParentView.render("index.json", %{item_parent: item_parent})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # update item parent
  swagger_path :update do
    put("/item-parents/{id}")
    summary("Update item parent")
    description("Update an existing Item.Parent")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the item parents to be updated", required: true
    parameter :item_parent, :body, Schema.ref(:Item_Parent), "Changes in item parents", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        collection_id: 1,
        item_type_id: 1,
        name: "Testo"
      }
    )
  end

  def update(conn, %{"id" => id} = params) do
    case Repo.get(Item.Parent, id) do
      nil ->
        Logger.error "L'item_parent n'existe pas."
        put_status(conn, 404)
      item_parent ->
        collection_id = params["collection_id"] || item_parent.collection_id
        item_type_id = params["item_type_id"] || item_parent.item_type_id
        name = params["name"] || item_parent.name
        case Repo.update Item.Parent.changeset(item_parent, %{collection_id: collection_id, item_type_id: item_type_id, name: name}) do
          {:ok, item_parent} ->
            put_status(conn, 200)
            |> ItemParentView.render("index.json", %{item_parent: item_parent})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete item parent
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/item-parents/{id}")
    summary("Delete item parent")
    description("Delete a Item.Parent by id")
    parameter :id, :path, :integer, "The id of the item parents to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with item_parent = %Item.Parent{} <- Repo.get(Item.Parent, id),
    {:ok, _} <- Repo.delete item_parent  do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
      nil ->
        Logger.error "L'item parent n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
