defmodule KiraBijoux.Repo.Migrations.CreateMaterialTypes do
  use Ecto.Migration

  def change do
    create table(:material_types) do
      add :name, :string

      timestamps()
    end

  end
end
