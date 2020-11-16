defmodule KiraBijoux.Article.Picture do
  use Ecto.Schema
  import Ecto.Changeset

  schema "article_pictures" do
    field :name, :string
    field :path, :string
    field :place, :integer
    field :article_id, :id

    timestamps()
  end

  @doc false
  def changeset(picture, attrs \\ %{}) do
    picture
    |> cast(attrs, [:article_id, :name, :path, :place])
    |> validate_required([:article_id, :name, :path, :place])
  end
end
