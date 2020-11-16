defmodule KiraBijoux.Component do
  use Ecto.Schema
  import Ecto.Changeset

  schema "components" do
    field :name, :string
    field :component_type_id, :id

    timestamps()
  end

  @doc false
  def changeset(component, attrs) do
    component
    |> cast(attrs, [:component_type_id, :name])
    |> validate_required([:component_type_id, :name])
  end
end
