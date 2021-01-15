defmodule KiraBijoux.Repo.Migrations.CreateItemTypes do
  use KiraBijouxWeb, :migration

  def change do
    create table(:item_types) do
      add :name, :string

      timestamps()
    end

  end
end
