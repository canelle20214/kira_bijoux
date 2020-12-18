defmodule KiraBijouxWeb.ItemView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{item: item}) do
    materials = Repo.all(from mi in Material.Item, select: mi.id, where: mi.item_id == ^item.id)
    item = Map.new(:name, item.name)
    |> Map.put(:description, item.description)
    |> Map.put(:price, item.price)
    |> Map.put(:materials, materials)
    |> Map.put(:visibility, item.visibility)
    conn
    |> json(item)
  end

  def render(conn, "show.json", %{item: item}) do
    materials = Repo.all(from mi in Material.Item, select: mi.id, where: mi.item_id == ^item.id)
    item = Map.new(:name, item.name)
    |> Map.put(:description, item.description)
    |> Map.put(:price, item.price)
    |> Map.put(:materials, materials)
    |> Map.put(:visibility, item.visibility)
    conn
    |> json(item)
  end

  def render(conn, "index.json", %{items: items}) do
    items = Enum.map(items, fn n ->
      materials = Repo.all(from mi in Material.Item, select: mi.id, where: mi.item_id == ^n.id)
      Map.new(:name, n.name)
      |> Map.put(:description, n.description)
      |> Map.put(:price, n.price)
      |> Map.put(:materials, materials)
      |> Map.put(:visibility, n.visibility)
    end)
    conn
    |> json(items)
  end

end
