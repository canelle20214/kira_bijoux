defmodule KiraBijoux.Page do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pages" do
    field :name, :string
    field :visibility, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(page, attrs \\ %{}) do
    page
    |> cast(attrs, [:name, :visibility])
    |> validate_required([:name, :visibility])
  end
end
