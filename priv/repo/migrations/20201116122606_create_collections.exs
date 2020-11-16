defmodule KiraBijoux.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections) do
      add :name, :string

      timestamps()
    end

  end
end
