defmodule KiraBijoux.Material.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "material_items" do
    field :material_id, :id
    field :item_id, :id

    timestamps()
  end

  @doc false
  def changeset(type, attrs \\ %{}) do
    type
    |> cast(attrs, [:material_id, :item_id])
    |> validate_required([:material_id, :item_id])
  end
end
