defmodule KiraBijoux.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :item_parent_id, :id
    field :price, :float
    field :stock, :integer
    field :description, :string
    field :visibility, :boolean, default: true
    timestamps()
  end

  @doc false
  def changeset(item, attrs \\ %{}) do
    item
    |> cast(attrs, [:item_parent_id, :price, :stock, :visibility])
    |> validate_required([:item_parent_id, :price, :stock, :visibility])
  end
end
