defmodule KiraBijoux.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :order_id, references(:orders, [ on_delete: :delete_all, on_update: :update_all ])
      add :product_item_id, references(:items, [ on_delete: :delete_all, on_update: :update_all ])
      add :quantity, :integer

      timestamps()
    end

    create index(:order_items, [:order_id])
    create index(:order_items, [:product_item_id])
  end
end
