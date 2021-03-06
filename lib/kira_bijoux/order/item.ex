defmodule KiraBijoux.Order.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do
    field :quantity, :integer
    field :order_id, :id
    field :item_id, :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs \\ %{}) do
    item
    |> cast(attrs, [:order_id, :item_id, :quantity])
    |> validate_required([:order_id, :item_id, :quantity])
  end
end
