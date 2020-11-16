defmodule KiraBijoux.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :material_id, references(:products, [ on_delete: :delete_all, on_update: :update_all ])
      add :collection_id, references(:collections, [ on_delete: :delete_all, on_update: :update_all ])
      add :name, :string
      add :price, :float
      add :stock, :integer
      add :visibility, :boolean, default: false, null: false

      timestamps()
    end

    create index(:items, [:material_id])
  end
end
