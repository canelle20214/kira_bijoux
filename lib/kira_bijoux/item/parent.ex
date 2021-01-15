defmodule KiraBijoux.Item.Parent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "item_parents" do
    field :name, :string
    field :item_type_id, :id
    field :collection_id, :id

    timestamps()
  end

  @doc false
  def changeset(name, attrs) do
    name
    |> cast(attrs, [:item_type_id, :collection_id, :name])
    |> validate_required([:item_type_id, :collection_id, :name])
  end
end
