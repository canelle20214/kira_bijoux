defmodule KiraBijoux.Newsletter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "newsletters" do
    field :name, :string
    field :cc, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(newsletter, attrs) do
    newsletter
    |> cast(attrs, [:name, :cc, :content])
    |> validate_required([:name, :cc, :content])
  end
end
