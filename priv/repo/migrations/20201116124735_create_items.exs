defmodule KiraBijoux.Repo.Migrations.CreateItems do
  use KiraBijouxWeb, :migration

  def change do
    create table(:items) do
      add :item_parent_id, references(:item_parents, [ on_delete: :delete_all, on_update: :update_all ])
      add :subtitle, :text
      add :description, :text
      add :length, :string
      add :price, :float
      add :stock, :integer
      add :visibility, :boolean, null: true

      timestamps()
    end
  end
end
