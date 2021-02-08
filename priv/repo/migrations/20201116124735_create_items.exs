defmodule KiraBijoux.Repo.Migrations.CreateItems do
  use KiraBijouxWeb, :migration

  def change do
    create table(:items) do
      add :item_parent_id, references(:item_parents, [ on_delete: :delete_all, on_update: :update_all ])
      add :description, :text
      add :price, :float
      add :stock, :integer
      add :visibility, :boolean, default: true, null: true

      timestamps()
    end
  end
end
