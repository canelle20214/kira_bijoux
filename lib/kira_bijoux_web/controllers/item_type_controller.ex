defmodule KiraBijouxWeb.ItemTypeController do
  use KiraBijouxWeb, :controller

  # get all item types
  swagger_path :index do
    get("/item-types")
    summary("Get all item types")
    description("List of item types")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
    item_types = Repo.all(from t in Item.Type, select: t)
    put_status(conn, 200)
    |> ItemTypeView.render("index.json", %{item_types: item_types})
  end

  def swagger_definitions do
    %{
      Item_Type: swagger_schema do
        title "Item.Type"
        description "Item.Type descr"
        properties do
          name :integer, "Name"
        end
      end
    }
  end

  # get item type by id
  swagger_path :show do
    get("/item-types/{id}")
    summary("Get item types by id")
    description("Item.Types filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    item_type = Repo.one(from t in Item.Type, select: t, where: t.id == ^id)
    if item_type == nil do
      Logger.error("l'item type n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      put_status(conn, 200)
      |> ItemTypeView.render("index.json", %{item_type: item_type})
    end
  end

  # create item type
  swagger_path :create do
    post("/item-types")
    summary("Create Item Types")
    description("Create a new Item.Types")
    produces "application/json"
    parameter :item_type, :body, Schema.ref(:Item_Type), "Item_Type", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Bague"
    })
  end

  def create(conn, params) do
    name = params["name"]
    case Repo.insert %Item.Type{name: name} do
      {:ok, item_type} ->
        put_status(conn, 201)
        |> ItemTypeView.render("index.json", %{item_type: item_type})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # update item type
  swagger_path :update do
    put("/item-types/{id}")
    summary("Update item type")
    description("Update an existing Item.Type")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the item type to be updated", required: true
    parameter :item_type, :body, Schema.ref(:Item_Type), "Changes in item type", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        name: "Anneau"
      }
    )
  end

  def update(conn, params) do
    item_type = Repo.get!(Item.Type, params["id"])
    name = params["name"] || item_type.name
    case Repo.update Item.Type.changeset(item_type, %{name: name}) do
      {:ok, item_type} ->
        put_status(conn, 200)
        |> ItemTypeView.render("index.json", %{item_type: item_type})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # delete item type
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/item-types/{id}")
    summary("Delete item types")
    description("Delete a Item.Types by id")
    parameter :id, :path, :integer, "The id of the item types to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete Repo.get!(Item.Type, id) do
      {:ok, item_type} ->
        put_status(conn, 200)
        |> ItemTypeView.render("index.json", %{item_type: item_type})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
