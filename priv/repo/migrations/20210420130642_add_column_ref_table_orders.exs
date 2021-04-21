defmodule KiraBijoux.Repo.Migrations.AddColumnRefTableOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :reference, :string
    end

  end
end
