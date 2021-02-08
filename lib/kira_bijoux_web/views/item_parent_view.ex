defmodule KiraBijouxWeb.ItemParentView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{item_parent: item_parent}) do
    conn
    |> json(item_parent_construction(item_parent))
  end

  def render(conn, "index.json", %{item_parents: item_parents}) do
    item_parents = Enum.map(item_parents, & item_parent_construction(&1))
    conn
    |> json(item_parents)
  end

  def item_parent_construction(item_parent) do
    type = Repo.get!(Item.Type, item_parent.item_type_id)
    |> KiraBijouxWeb.ItemTypeView.item_type_construction()
    collection = Repo.get!(Collection, item_parent.collection_id)
    |> KiraBijouxWeb.CollectionView.collection_construction()
    Map.new(id: item_parent.id)
    |> Map.put(:name, item_parent.name)
    |> Map.put(:item_type, type)
    |> Map.put(:collection, collection)
    |> Map.put(:inserted_at, item_parent.inserted_at)
    |> Map.put(:updated_at, item_parent.updated_at)
  end
end
