defmodule KiraBijouxWeb.ItemView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{item: item}) do
    conn
    |> json(item_construction(item))
  end

  def render(conn, "index.json", %{items: items}) do
    items = Enum.map(items, fn n ->
      item_construction(n)
    end)
    conn
    |> json(items)
  end

  def item_construction(item) do
    materials = Repo.all(from mi in Material.Item, select: mi, where: mi.item_id == ^item.id)
    parent = Repo.get!(Item.Parent, item.item_parent_id)
    type = Repo.get!(Item.Type, parent.item_type_id)
    collection = Repo.get!(Collection, parent.collection_id)
    Map.new(name: parent.name)
    |> Map.put(:description, item.description)
    |> Map.put(:stock, item.stock)
    |> Map.put(:price, item.price)
    |> Map.put(:materials, materials)
    |> Map.put(:item_type, type)
    |> Map.put(:collection, collection)
    |> Map.put(:visibility, item.visibility)
    |> Map.put(:inserted_at, item.inserted_at)
    |> Map.put(:updated_at, item.updated_at)
  end
end