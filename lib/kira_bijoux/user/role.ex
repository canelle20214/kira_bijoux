defmodule KiraBijoux.User.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_roles" do
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(role, attrs \\ %{}) do
    role
    |> cast(attrs, [:role])
    |> validate_required([:role])
  end
end
