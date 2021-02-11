defmodule KiraBijouxWeb.ItemController do
  use KiraBijouxWeb, :controller

  # get all items
  swagger_path :index do
    get("/items")
    summary("Get all items")
    description("List of items")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    items = Repo.all(from i in Item, select: i)
    put_status(conn, 200)
    |> ItemView.render("index.json", %{items: items})
  end

  def swagger_schema do
    %{
      Item: swagger_schema do
        title "Item"
        description "Item descr"
        properties do
          name :string, "Subtitle"
          subtitle :string, "Subtitle"
          description :string, "Description"
          price :number, "Price"
          length :string, "Length"
          stock :integer, "Stock"
          visibility :boolean, "Visibility"
          materials :array, "Material"
          collection_id :integer, "Collection id"
          item_type_id :integer, "Item type id"
        end
      end
    }
  end

  # create item
  swagger_path :create do
    post("/items")
    summary("Create item")
    description("Create a new item")
    parameter :item, :body, Schema.ref(:Item), "Item", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
          name: "Collier",
          subtitle: "Collier",
          description: "Collier",
          price: 35.5,
          length: "35 cm",
          stock: 4,
          visibility: true,
          materials: [1,4],
          collection_id: 1,
          item_type_id: 1
        })
    produces "application/json"
    response(200, "OK", Schema.ref(:Item),
      example:
      %{
        item:
        %{
          name: "Collier",
          subtitle: "Collier",
          description: "Collier",
          price: 35.5,
          length: "35 cm",
          stock: 4,
          visibility: true,
          materials: [1,4],
          collection_id: 1,
          item_type_id: 1
        }
      }
    )
  end

  def create(conn, params) do
    name = params["name"]
    price = params["price"]
    subtitle = params["subtitle"]
    description = params["description"]
    length = params["length"]
    stock = params["stock"]
    visibility = params["visibility"]
    material_ids = params["materials"]
    type = params["item_type_id"]
    collection = params["collection_id"]
    parent =
      case Repo.one(from it in Item.Parent, where: it.item_type_id == ^type and it.name == ^name) do
        nil ->
          Repo.insert!(%Item.Parent{name: name, item_type_id: type, collection_id: collection})
        p ->
          p
      end
    materials = Repo.all(from m in Material, select: m, where: m.id in ^material_ids)
    case Repo.insert %Item{item_parent_id: parent.id, subtitle: subtitle, length: length, price: price, stock: stock, description: description, visibility: visibility} do
      {:ok, item} ->
        b = materials
        |> Enum.map(&Repo.insert %Material.Item{material_id: &1.id, item_id: item.id})
        |> Enum.all?(& &1 = {:ok, %Material.Item{}})
        if b do
            put_status(conn, 201)
            |> ItemView.render("index.json", %{item: item})
        else
            put_status(conn, :conflict)
            |> ItemView.render("index.json", %{item: item})
        end

      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # get item by id
  swagger_path :show do
    get("/items/{id}")
    summary("Get item by id")
    description("Item filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)
    put_status(conn, 200)
    |> ItemView.render("index.json", %{item: item})
  end


  # get item by category
  swagger_path :showByCategory do
    get("/items/category/{name}")
    summary("Get item by category")
    description("Item filtered by category")
    parameter :name, :path, :string, "The name of the category of item to be display", required: true
    response(code(:ok), "Success")
  end

  def showByCategory(conn, %{"name" => name}) do
    items = Repo.all(from i in Item, select: i,
      join: ip in Item.Parent, on: i.item_parent_id == ip.id,
      join: it in Item.Type, on: ip.item_type_id == it.id,
      where: it.name == ^name)
    if items == [] do
      Logger.error("aucun items trouver")
      put_status(conn, 404)
      |> json([])
    else
      Logger.info("recherche items en cours")
      put_status(conn, 200)
      |> ItemView.render("index.json", %{items: items})
    end
  end


  # get item by name
  swagger_path :showByName do
    get("/items/category/item/{name}")
    summary("Get item by name")
    description("Item filtered by name")
    parameter :name, :path, :string, "The name of the item to be display", required: true
    response(code(:ok), "Success")
  end

  def showByName(conn, %{"name" => name}) do
    item = Repo.all(from i in Item, select: i,
      join: ip in Item.Parent, on: i.item_parent_id == ip.id,
      where: ilike(ip.name, ^"%#{name}%"))
    if item == [] do
      Logger.error("l'item n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      Logger.info("recherche item en cours")
      put_status(conn, 200)
      |> ItemView.render("index.json", %{items: item})
    end
  end


  # update item
  swagger_path :update do
    put("/items/{id}")
    summary("Update item")
    description("Update an existing item")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the item to be updated", required: true
    parameter :item, :body, Schema.ref(:Item), "Changes in item", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        name: "Collier",
        subtitle: "Collier",
        description: "Collier",
        price: 35.5,
        length: "35 cm",
        stock: 4,
        visibility: true,
        materials: [1,4],
        collection_id: 1,
        item_type_id: 1
      }
    )
  end

  def update(conn, params) do
    item = Repo.get!(Item, params["id"])
    parent = Repo.get!(Item.Parent, item.item_parent_id)
    name = params["name"] || parent.name
    price = params["price"] || item.price
    stock = params["stock"] || item.stock
    subtitle = params["subtitle"] || item.subtitle
    description = params["description"] || item.description
    length = params["length"] || item.length
    type = params["item_type_id"] || parent.item_type_id
    collection = params["collection_id"] || parent.collection_id
    visibility = params["visibility"] || item.visibility
    existing_materials = Repo.all(from mi in Material.Item, select: mi.id, where: mi.item_id == ^item.id)
    materials = params["materials"] || existing_materials
    parent =
      case Repo.one(from it in Item.Parent, where: it.item_type_id == ^type and it.collection_id == ^collection and it.name == ^name) do
        nil ->
          Repo.insert!(%Item.Parent{name: name, item_type_id: type, collection_id: collection})
        p ->
          p
      end
    case Repo.update Item.changeset(item, %{item_parent_id: parent.id, subtitle: subtitle, length: length, price: price, stock: stock, description: description, visibility: visibility}) do
      {:ok, item} ->
        if Enum.all?(existing_materials, & Enum.member?(materials, &1)) && length(existing_materials) == length(materials) do
          put_status(conn, 200)
          |> ItemView.render("index.json", %{item: item})
        else
          Enum.each(existing_materials, & Repo.delete!(Repo.get!(Material.Item, &1)))
          Enum.map(materials, & Repo.insert!(%Material.Item{material_id: &1, item_id: item.id}))
          put_status(conn, 200)
          |> ItemView.render("index.json", %{item: item})
        end
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # delete item
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/items/{id}")
    summary("Delete Item")
    description("Delete a Item by id")
    parameter :id, :path, :integer, "The id of the item to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete Repo.get!(Item, id) do
      {:ok, item} ->
        #Phoenix.json/2 cannot render 204 status https://git.pleroma.social/pleroma/pleroma/-/issues/2029
        put_status(conn, 200)
        |> ItemView.render("index.json", %{item: item})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
