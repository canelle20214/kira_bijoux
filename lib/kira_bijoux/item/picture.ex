defmodule KiraBijoux.Item.Picture do
  use Ecto.Schema
  import Ecto.Changeset

  schema "item_pictures" do
    field :name, :string
    field :path, :string
    field :place, :integer
    field :product_item_id, :id

    timestamps()
  end

  @doc false
  def changeset(picture, attrs) do
    picture
    |> cast(attrs, [:product_item_id, :name, :path, :place])
    |> validate_required([:product_item_id, :name, :path, :place])
  end
end
