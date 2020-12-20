defmodule KiraBijoux.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :page_id, :id
    field :template_id, :id
    field :name, :string
    field :content, :string
    field :place, :integer

    timestamps()
  end

  @doc false
  def changeset(article, attrs \\ %{}) do
    article
    |> cast(attrs, [:page_id, :template_id, :name, :content, :place])
    |> validate_required([:page_id, :template_id, :name, :content, :place])
  end
end
