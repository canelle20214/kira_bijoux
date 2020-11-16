defmodule KiraBijoux.Repo.Migrations.CreateComponentTypes do
  use Ecto.Migration

  def change do
    create table(:component_types) do
      add :name, :string

      timestamps()
    end

  end
end
