defmodule KiraBijoux.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :price, :float
    field :order_status_id, :id
    field :user_address_id, :id

    timestamps()
  end

  @doc false
  def changeset(order, attrs \\ %{}) do
    order
    |> cast(attrs, [:order_status_id, :user_address_id, :price])
    |> validate_required([:order_status_id, :user_address_id, :price])
  end
end
