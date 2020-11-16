defmodule KiraBijoux.Order.Status do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_status" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
