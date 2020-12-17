defmodule KiraBijouxWeb.ItemController do
  use KiraBijouxWeb, :controller

  def index(conn, _params) do
    items = Repo.all(from i in Item, select: i)
    put_status(conn, 200)
    |> ItemView.render("index.json", %{items: items})
  end

  def create(conn, params) do
    name = params["name"]
    price = params["price"]
    description = params["description"]
    visibility = params["visibility"]
    material_ids = params["materials"]
    materials = Repo.all(from m in Material, select: m, where: m.id in ^material_ids)
    case Repo.insert %Item{name: name, price: price, description: description, visibility: visibility} do
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

  def show(conn, %{"item_id" => id}) do
    item = Repo.get!(Item, id)
    put_status(conn, 200)
    |> ItemView.render("show.json", %{item: item})
  end

  def update(conn, params) do
    item = Repo.get!(Item, params["item_id"])
    name = params["name"] || item.name
    price = params["price"] || item.price
    description = params["description"] || item.description
    visibility = params["visibility"] || item.visibility
    existing_materials = Repo.all(from mi in Material.Item, select: mi.id, where: mi.item_id == ^item.id)
    materials = params["materials"] || existing_materials
    case Repo.update User.changeset(item, %{name: name, price: price, description: description, visibility: visibility}) do
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
