defmodule KiraBijoux.Repo.Migrations.CreateOrderStatus do
  use KiraBijouxWeb, :migration

  def change do
    create table(:order_status) do
      add :name, :string

      timestamps()
    end

  end
end
