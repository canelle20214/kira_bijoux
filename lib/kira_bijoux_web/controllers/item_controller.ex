defmodule KiraBijouxWeb.ItemController do
  import Plug.Conn.Status, only: [code: 1]
  use KiraBijouxWeb, :controller
  use PhoenixSwagger

  # get all items
  swagger_path :index do
    get("/items")
    summary("Get all items")
    description("List of items")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
    items = Repo.all(from i in Item, select: i)
    put_status(conn, 200)
    |> ItemView.render("index.json", %{items: items})
  end


  # create item
  swagger_path :create do
    post("/items")
    summary("Create item")
    description("Create a new item")
    produces "application/json"
    parameters do
      name :query, :string, "The name of the item to be created", required: true
      price :query, :number, "The price of the item to be created", required: true
      description :query, :string, "The description of the item to be created", required: true
      stock :query, :integer, "The stock of the item to be created", required: true
      visibility :query, :boolean, "The visibility of the item to be created", required: true
      materials :query, :integer, "The materials of the item to be created", required: true
      item_type_id :query, :integer, "The item_type_id of the item to be created", required: true
      collection_id :query, :integer, "The collection_id of the item to be created", required: true
    end
  end

  def create(conn, params) do
    name = params["name"]
    price = params["price"]
    description = params["description"]
    stock = params["stock"]
    visibility = params["visibility"]
    material_ids = params["materials"]
    type = params["item_type_id"]
    collection = params["collection_id"]
    parent =
      case Repo.one(from it in Item.Parent, where: it.item_type_id == ^type and it.name == ^name) do
        {:ok, p} ->
          p
        {:error, _} ->
          Repo.insert!(%Item.Parent{name: name, item_type_id: type, collection_id: collection})
      end
    materials = Repo.all(from m in Material, select: m, where: m.id in ^material_ids)
    case Repo.insert %Item{item_parent_id: parent.id, name: name, price: price, stock: stock, description: description, visibility: visibility} do
      {:ok, item} ->
        b = materials
        |> Enum.map(&Repo.insert %Material.Item{material_id: &1.id, item_id: item.id})
        |> Enum.all?(& &1 == {:ok, %Material.Item{}})
        if b do
            put_status(conn, 201)
            |> ItemView.render("index.json", %{item: item})
        else
            put_status(conn, :not_linked)
            |> ItemView.render("index.json", %{item: item})
        end

      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # get item by id
  swagger_path :show do
    get("/items/{item_id}")
    summary("Get item by id")
    description("Item filtered by id")
    parameter :item_id, :path, :integer, "The id of the item to be display", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"item_id" => id}) do
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
    else
      Logger.info("recherche item en cours")
      put_status(conn, 200)
      |> ItemView.render("index.json", %{items: item})
    end
  end


  # update item
  swagger_path :update do
    put("/items/{item_id}")
    summary("Update item")
    description("Update an existing item")
    produces "application/json"
    parameter :item_id, :path, :integer, "The id of the item to be updated", required: true
    parameters do
      name :query, :string, "The name of the item to be created", required: true
      price :query, :number, "The price of the item to be created", required: true
      description :query, :string, "The description of the item to be created", required: true
      stock :query, :integer, "The stock of the item to be created", required: true
      visibility :query, :boolean, "The visibility of the item to be created", required: true
      materials :query, :integer, "The materials of the item to be created", required: true
      item_type_id :query, :integer, "The item_type_id of the item to be created", required: true
      collection_id :query, :integer, "The collection_id of the item to be created", required: true
    end
  end

  def update(conn, params) do
    item = Repo.get!(Item, params["item_id"])
    name = params["name"] || item.name
    price = params["price"] || item.price
    stock = params["stock"] || item.stock
    description = params["description"] || item.description
    type = params["item_type_id"]
    collection = params["collection_id"]
    visibility = params["visibility"] || item.visibility
    existing_materials = Repo.all(from mi in Material.Item, select: mi.id, where: mi.item_id == ^item.id)
    materials = params["materials"] || existing_materials
    parent =
      case Repo.one(from it in Item.Parent, where: it.item_type_id == ^type and it.collection_id == ^collection and it.name == ^name) do
        {:ok, p} ->
          p
        {:error, _} ->
          Repo.insert!(%Item.Parent{name: name, item_type_id: type, collection_id: collection})
      end
    case Repo.update Item.changeset(item, %{item_parent_id: parent.id, name: name, price: price, stock: stock, description: description, visibility: visibility}) do
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
    PhoenixSwagger.Path.delete("/items/{item_id}")
    summary("Delete Item")
    description("Delete a Item by id")
    parameter :item_id, :path, :integer, "The id of the item to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"item_id" => id}) do
    case Repo.delete Repo.get!(Item, id) do
      {:ok, item} ->
        put_status(conn, 200)
        |> ItemView.render("index.json", %{item: item})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
