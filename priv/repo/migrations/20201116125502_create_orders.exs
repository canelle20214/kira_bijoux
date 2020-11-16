defmodule KiraBijoux.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :order_status_id, references(:order_status, [ on_delete: :delete_all, on_update: :update_all ])
      add :user_address_id, references(:user_addresses, [ on_delete: :delete_all, on_update: :update_all ])
      add :price, :float

      timestamps()
    end

    create index(:orders, [:order_status_id])
    create index(:orders, [:user_address_id])
  end
end
