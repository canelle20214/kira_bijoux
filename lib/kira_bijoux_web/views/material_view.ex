defmodule KiraBijouxWeb.MaterialView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{material: material}) do
    conn
    |> json(material_construction(material))
  end

  def render(conn, "index.json", %{materials: materials}) do
    materials = Enum.map(materials, & material_construction(&1))
    conn
    |> json(materials)
  end

  def material_construction(material) do
    type = Repo.get!(Material.Type, material.material_type_id)
    |> KiraBijouxWeb.MaterialTypeView.material_type_construction()
    Map.new(id: material.id)
    |> Map.put(:name, material.name)
    |> Map.put(:material_type, type)
    |> Map.put(:inserted_at, material.inserted_at)
    |> Map.put(:updated_at, material.updated_at)
  end
end
