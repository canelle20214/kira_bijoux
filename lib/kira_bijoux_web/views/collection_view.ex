defmodule KiraBijouxWeb.CollectionView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{collection: collection}) do
    conn
    |> json(collection_construction(collection))
  end

  def render(conn, "index.json", %{collections: collections}) do
    collections = Enum.map(collections, & collection_construction(&1))
    conn
    |> json(collections)
  end

  def collection_construction(collection) do
    Map.new(id: collection.id)
    |> Map.put(:name, collection.name)
    |> Map.put(:inserted_at, collection.inserted_at)
    |> Map.put(:updated_at, collection.updated_at)
  end
end
