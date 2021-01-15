defmodule KiraBijoux.Repo.Migrations.CreateItemParents do
  use KiraBijouxWeb, :migration

  def change do
    create table(:item_parents) do
      add :name, :string
      add :item_type_id, references(:item_types, [ on_delete: :delete_all, on_update: :update_all ])
      add :collection_id, references(:collections, [ on_delete: :delete_all, on_update: :update_all ])

      timestamps()
    end

  end
end
