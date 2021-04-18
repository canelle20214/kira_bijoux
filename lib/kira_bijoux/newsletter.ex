defmodule KiraBijoux.Newsletter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "newsletters" do
    field :name, :string
    field :object, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(newsletter, attrs) do
    newsletter
    |> cast(attrs, [:name, :object, :content])
    |> validate_required([:name, :object, :content])
  end
end
