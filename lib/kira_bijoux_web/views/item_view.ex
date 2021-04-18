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
    materials = Repo.all(from m in Material,
    select: m,
    join: mi in Material.Item, on: m.id == mi.material_id,
    where: mi.item_id == ^item.id)
    |> Enum.map(&KiraBijouxWeb.MaterialView.material_construction(&1))
    parent = Repo.get!(Item.Parent, item.item_parent_id)
    |> KiraBijouxWeb.ItemParentView.item_parent_construction()
    type = Repo.get!(Item.Type, parent.item_type.id)
    |> KiraBijouxWeb.ItemTypeView.item_type_construction()
    collection = Repo.get!(Collection, parent.collection.id)
    |> KiraBijouxWeb.CollectionView.collection_construction()
    pictures = Repo.all(from ip in Item.Picture, select: ip, where: ip.item_id == ^item.id)
    |> Enum.map(&KiraBijouxWeb.ItemPictureView.item_picture_construction(&1))
    Map.new(id: item.id)
    |> Map.put(:name, parent.name)
    |> Map.put(:subtitle, item.subtitle)
    |> Map.put(:description, item.description)
    |> Map.put(:length, item.length)
    |> Map.put(:stock, item.stock)
    |> Map.put(:tva, item.tva)
    |> Map.put(:price, item.price)
    |> Map.put(:materials, materials)
    |> Map.put(:item_type, type)
    |> Map.put(:item_pictures, pictures)
    |> Map.put(:collection, collection)
    |> Map.put(:visibility, item.visibility)
    |> Map.put(:inserted_at, item.inserted_at)
    |> Map.put(:updated_at, item.updated_at)
  end
end
