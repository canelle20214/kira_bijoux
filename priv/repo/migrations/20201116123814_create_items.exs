defmodule KiraBijoux.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :collection_id, references(:collections, [ on_delete: :delete_all, on_update: :update_all ])
      add :item_type_id, references(:item_types, [ on_delete: :delete_all, on_update: :update_all ])
      add :name, :string
      add :description, :text
      add :price, :float
      add :stock, :integer
      add :visibility, :boolean, default: false, null: false

      timestamps()
    end
  end
end
