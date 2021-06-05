defmodule KiraBijouxWeb.ItemTypeController do
  use KiraBijouxWeb, :controller

  # get all item types
  swagger_path :index do
    get("/item-types")
    summary("Get all item_types")
    description("List of Item.Type")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    item_types = Repo.all(from it in Item.Type, select: it)
    put_status(conn, 200)
    |> ItemTypeView.render("index.json", %{item_types: item_types})
  end

  def swagger_definitions do
    %{
      item_type: swagger_schema do
        title "Item.Type"
        description "Item.Type descr"
        properties do
          name :string, "Name"
        end
      end
    }
  end

  # create item_type
  swagger_path :create do
    post("/item-types")
    summary("Create item_type")
    description("Create a new Item.Type")
    parameter :item_type, :body, Schema.ref(:item_type), "Item.Type", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
          name: "Collier"
        })
    produces "application/json"
    response(200, "OK", Schema.ref(:item_type),
      example:
      %{
        item_type:
        %{
          name: "Collier",
        }
      }
    )
  end

  def create(conn, %{"name" => name}) do
    case Repo.insert %Item.Type{name: name} do
      {:ok, item_type} ->
        put_status(conn, 201)
        |> ItemTypeView.render("index.json", %{item_type: item_type})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400)

  # get item type by id
  swagger_path :show do
    get("/item-types/{id}")
    summary("Get item_type by id")
    description("Item.Type filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    item_type = Repo.get!(Item.Type, id)
    case item_type do
      nil ->
        Logger.error("le type d'item n'existe pas")
        put_status(conn, 404)
        |> json(%{})
      item_type ->
        put_status(conn, 200)
        |> ItemTypeView.render("index.json", %{item_type: item_type})
    end

  end


  # update item type
  swagger_path :update do
    put("/item-types/{id}")
    summary("Update item_type")
    description("Update an existing Item.Type")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the item type to be updated", required: true
    parameter :item_type, :body, Schema.ref(:item_type), "Changes in item type", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        name: "Collier"
      }
    )
  end

  def update(conn, %{"id" => id, "name" => name}) do
    item_type = Repo.get!(Item.Type, id)
    case Repo.update Item.Type.changeset(item_type, %{name: name}) do
      {:ok, item_type} ->
        put_status(conn, 200)
        |> ItemTypeView.render("index.json", %{item_type: item_type})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
  def update(conn, _), do: put_status(conn, 400)

  # delete item_type
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/item-types/{id}")
    summary("Delete item_type")
    description("Delete a Item.Type by id")
    parameter :id, :path, :integer, "The id of the item type to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete Repo.get!(Item.Type, id) do
      {:ok, item_type} ->
        #Phoenix.json/2 cannot render 204 status https://git.pleroma.social/pleroma/pleroma/-/issues/2029
        put_status(conn, 200)
        |> ItemTypeView.render("index.json", %{item_type: item_type})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
