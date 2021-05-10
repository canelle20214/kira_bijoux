defmodule KiraBijoux.User.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_favorites" do
    field :user_id, :id
    field :item_id, :id

    timestamps()
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:user_id, :item_id])
    |> validate_required([:user_id, :item_id])
  end
end
