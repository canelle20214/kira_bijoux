defmodule KiraBijouxWeb.ItemPictureView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{item_picture: item_picture}) do
    conn
    |> json(item_picture_construction(item_picture))
  end

  def render(conn, "index.json", %{item_pictures: item_pictures}) do
    item_pictures = Enum.map(item_pictures, & item_picture_construction(&1))
    conn
    |> json(item_pictures)
  end

  def item_picture_construction(item_picture) do
    Map.new(id: item_picture.id)
    |> Map.put(:name, item_picture.name)
    |> Map.put(:place, item_picture.place)
    |> Map.put(:path, item_picture.path)
    |> Map.put(:inserted_at, item_picture.inserted_at)
    |> Map.put(:updated_at, item_picture.updated_at)
  end
end
