defmodule KiraBijoux.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :item_parent_id, :id
    field :subtitle, :string
    field :price, :float
    field :tva, :float
    field :length, :string
    field :stock, :integer
    field :description, :string
    field :visibility, :boolean
    timestamps()
  end

  @doc false
  def changeset(item, attrs \\ %{}) do
    item
    |> cast(attrs, [:item_parent_id, :description, :subtitle, :price, :length, :stock, :tva, :visibility])
    |> validate_required([:item_parent_id, :subtitle, :price, :length, :stock, :tva, :visibility])
  end
end
