defmodule KiraBijoux.User.Newsletter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_newsletters" do
    field :user_id, :id
    field :newsletter_id, :id
    field :item_id, :id
    field :mail, :string

    timestamps()
  end

  @doc false
  def changeset(newsletter, attrs) do
    newsletter
    |> cast(attrs, [:user_id, :newsletter_id, :item_id, :mail])
    |> check_constraint(:user_newsletters, name: :user_newsletters_constraint)
    |> validate_required([:newsletter_id])
  end
end
