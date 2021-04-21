defmodule KiraBijoux.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :price, :float
    field :reference, :string
    field :order_status_id, :id
    field :user_address_id, :id
    field :payment_type_id, :id
    field :send_at, :naive_datetime
    field :received_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(order, attrs \\ %{}) do
    order
    |> cast(attrs, [:order_status_id, :user_address_id, :payment_type_id, :reference, :price, :send_at, :received_at])
    |> validate_required([:order_status_id, :user_address_id, :payment_type_id, :reference, :price])
  end
end
