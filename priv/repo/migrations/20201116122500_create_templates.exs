defmodule KiraBijoux.Repo.Migrations.CreateTemplates do
  use Ecto.Migration

  def change do
    create table(:templates) do
      add :name, :string
      add :color, :string

      timestamps()
    end

  end
end
