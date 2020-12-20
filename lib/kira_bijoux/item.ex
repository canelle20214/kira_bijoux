defmodule KiraBijoux.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :price, :float
    field :description, :string
    field :visibility, :boolean, default: false
    field :item_type_id, :id
    field :collection_id, :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs \\ %{}) do
    item
    |> cast(attrs, [:item_type_id, :collection_id, :name, :price, :visibility])
    |> validate_required([:item_type_id, :collection_id, :name, :price, :visibility])
  end
end
