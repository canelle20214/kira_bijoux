defmodule KiraBijoux.User.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_addresses" do
    field :first_line, :string
    field :name, :string
    field :post_code, :string
    field :recipient, :string
    field :second_line, :string
    field :town, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(address, attrs \\ %{}) do
    address
    |> cast(attrs, [:user_id, :name, :recipient, :first_line, :second_line, :post_code, :town])
    |> validate_required([:user_id, :name, :recipient, :first_line, :second_line, :post_code, :town])
  end
end
