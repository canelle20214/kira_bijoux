defmodule KiraBijoux.Repo.Migrations.CreateCollections do
  use KiraBijouxWeb, :migration

  def change do
    create table(:collections) do
      add :name, :string

      timestamps()
    end

  end
end
