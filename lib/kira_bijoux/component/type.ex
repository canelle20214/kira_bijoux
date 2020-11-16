defmodule KiraBijoux.Component.Type do
  use Ecto.Schema
  import Ecto.Changeset

  schema "component_types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
