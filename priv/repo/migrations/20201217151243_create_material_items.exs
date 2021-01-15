defmodule KiraBijoux.Repo.Migrations.CreateMaterialItems do
  use KiraBijouxWeb, :migration

  def change do
    create table(:material_items) do
      add :material_id, references(:materials, [ on_delete: :delete_all, on_update: :update_all ])
      add :item_id, references(:items, [ on_delete: :delete_all, on_update: :update_all ])

      timestamps()
    end

    create index(:material_items, [:material_id])
    create index(:material_items, [:item_id])
  end
end
