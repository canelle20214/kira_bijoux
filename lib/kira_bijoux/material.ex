defmodule KiraBijoux.Material do
  use Ecto.Schema
  import Ecto.Changeset

  schema "materials" do
    field :name, :string
    field :material_type_id, :id

    timestamps()
  end

  @doc false
  def changeset(product, attrs \\ %{}) do
    product
    |> cast(attrs, [:material_type_id, :name])
    |> validate_required([:material_type_id, :name])
  end
end
