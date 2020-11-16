defmodule KiraBijoux.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :name, :string
      add :visibility, :boolean, default: false, null: false

      timestamps()
    end

  end
end
