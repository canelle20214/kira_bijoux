defmodule KiraBijoux.Repo.Migrations.AddColumnRefTableOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :reference, :text
    end

  end
end
