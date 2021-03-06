defmodule KiraBijoux.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :firstname, :string
    field :lastname, :string
    field :mail, :string
    field :phone, :string
    field :password, :string
    field :user_role_id, :id

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:user_role_id, :firstname, :lastname, :mail, :phone, :password])
    |> validate_required([:user_role_id, :firstname, :lastname, :mail, :password])
  end
end
