defmodule KiraBijoux.Repo.Migrations.CreateOrderStatus do
  use Ecto.Migration

  def change do
    create table(:order_status) do
      add :name, :string

      timestamps()
    end

  end
end
