defmodule KiraBijoux.Repo.Migrations.CreateMaterials do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :material_type_id, references(:material_types, [ on_delete: :delete_all, on_update: :update_all ])
      add :name, :string

      timestamps()
    end

    create index(:products, [:material_type_id])
  end
end
