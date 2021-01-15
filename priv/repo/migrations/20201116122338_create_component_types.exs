defmodule KiraBijoux.Repo.Migrations.CreateComponentTypes do
  use KiraBijouxWeb, :migration

  def change do
    create table(:component_types) do
      add :name, :string

      timestamps()
    end

  end
end
