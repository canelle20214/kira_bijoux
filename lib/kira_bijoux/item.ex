defmodule KiraBijoux.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :price, :float
    field :visibility, :boolean, default: false
    field :material_id, :id
    field :collection_id, :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs \\ %{}) do
    item
    |> cast(attrs, [:material_id, :collection_id, :name, :price, :visibility])
    |> validate_required([:material_id, :collection_id, :name, :price, :visibility])
  end
end
