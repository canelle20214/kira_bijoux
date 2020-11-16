defmodule KiraBijoux.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :content, :string
    field :name, :string
    field :place, :integer
    field :page_id, :id

    timestamps()
  end

  @doc false
  def changeset(article, attrs \\ %{}) do
    article
    |> cast(attrs, [:page_id, :name, :content, :place])
    |> validate_required([:page_id, :name, :content, :place])
  end
end
