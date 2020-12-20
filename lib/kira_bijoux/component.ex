defmodule KiraBijoux.Component do
  use Ecto.Schema
  import Ecto.Changeset

  schema "components" do
    field :template_id, :id
    field :page_id, :id
    field :component_type_id, :id
    field :name, :string
    field :content, :string
    field :place, :integer

    timestamps()
  end

  @doc false
  def changeset(component, attrs \\ %{}) do
    component
    |> cast(attrs, [:component_type_id, :template_id, :page_id, :name, :content])
    |> validate_required([:component_type_id, :template_id, :page_id, :name])
  end
end
