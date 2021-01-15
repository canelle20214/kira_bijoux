defmodule KiraBijoux.Repo.Migrations.CreateOrders do
  use KiraBijouxWeb, :migration

  def change do
    create table(:orders) do
      add :order_status_id, references(:order_status, [ on_delete: :delete_all, on_update: :update_all ])
      add :user_address_id, references(:user_addresses, [ on_delete: :delete_all, on_update: :update_all ])
      add :payment_type_id, references(:payment_types, [ on_delete: :delete_all, on_update: :update_all ])
      add :price, :float

      timestamps()
    end

    create index(:orders, [:order_status_id])
    create index(:orders, [:user_address_id])
    create index(:orders, [:payment_type_id])
  end
end
