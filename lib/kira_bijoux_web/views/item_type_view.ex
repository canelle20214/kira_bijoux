defmodule KiraBijouxWeb.ItemTypeView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{item_type: item_type}) do
    conn
    |> json(item_type_construction(item_type))
  end

  def render(conn, "index.json", %{item_types: item_types}) do
    item_types = Enum.map(item_types, & item_type_construction(&1))
    conn
    |> json(item_types)
  end

  def item_type_construction(item_type) do
    Map.new(id: item_type.id)
    |> Map.put(:name, item_type.name)
    |> Map.put(:inserted_at, item_type.inserted_at)
    |> Map.put(:updated_at, item_type.updated_at)
  end
end
