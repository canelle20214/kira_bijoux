defmodule KiraBijoux.Repo.Migrations.CreateArticlePictures do
  use Ecto.Migration

  def change do
    create table(:article_pictures) do
      add :article_id, references(:articles, [ on_delete: :delete_all, on_update: :update_all ])
      add :name, :string
      add :path, :text
      add :place, :integer

      timestamps()
    end

    create index(:article_pictures, [:article_id])
  end
end
