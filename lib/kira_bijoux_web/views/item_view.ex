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
    Map.new(:name, item.name)
    |> Map.put(:description, item.description)
    |> Map.put(:price, item.price)
    |> Map.put(:materials, materials)
    |> Map.put(:item_type_id, item.item_type_id)
    |> Map.put(:visibility, item.visibility)
    |> Map.put(:inserted_at, item.inserted_at)
    |> Map.put(:updated_at, item.updated_at)
  end
end
