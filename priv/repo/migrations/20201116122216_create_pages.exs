defmodule KiraBijoux.Repo.Migrations.CreatePages do
  use KiraBijouxWeb, :migration

  def change do
    create table(:pages) do
      add :name, :string
      add :visibility, :boolean, default: true, null: true

      timestamps()
    end

  end
end
