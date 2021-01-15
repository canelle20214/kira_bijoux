defmodule KiraBijoux.Repo.Migrations.CreateMaterials do
  use KiraBijouxWeb, :migration

  def change do
    create table(:materials) do
      add :material_type_id, references(:material_types, [ on_delete: :delete_all, on_update: :update_all ])
      add :name, :string

      timestamps()
    end

    create index(:materials, [:material_type_id])
  end
end
