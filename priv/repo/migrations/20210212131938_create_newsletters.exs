defmodule KiraBijoux.Repo.Migrations.CreateNewsletters do
  use Ecto.Migration

  def change do
    create table(:newsletters) do
      add :name, :string
      add :object, :string
      add :content, :text

      timestamps()
    end
  end
end
