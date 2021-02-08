defmodule KiraBijouxWeb.MaterialTypeView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{material_type: material_type}) do
    conn
    |> json(material_type_construction(material_type))
  end

  def render(conn, "index.json", %{material_types: material_types}) do
    material_types = Enum.map(material_types, & material_type_construction(&1))
    conn
    |> json(material_types)
  end

  def material_type_construction(material_type) do
    Map.new(id: material_type.id)
    |> Map.put(:name, material_type.name)
    |> Map.put(:inserted_at, material_type.inserted_at)
    |> Map.put(:updated_at, material_type.updated_at)
  end
end
