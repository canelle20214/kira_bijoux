defmodule KiraBijoux.Repo.Migrations.AlterTableOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :send_at, :utc_datetime
      add :received_at, :utc_datetime
    end

    alter table(:items) do
      add :tva, :float, default: 0.2
    end
  end
end
