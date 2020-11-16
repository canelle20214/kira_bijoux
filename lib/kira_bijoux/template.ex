defmodule KiraBijoux.Template do
  use Ecto.Schema
  import Ecto.Changeset

  schema "templates" do
    field :color, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(template, attrs) do
    template
    |> cast(attrs, [:name, :color])
    |> validate_required([:name, :color])
  end
end
