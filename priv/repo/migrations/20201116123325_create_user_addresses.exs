defmodule KiraBijoux.Repo.Migrations.CreateUserAddresses do
  use KiraBijouxWeb, :migration

  def change do
    create table(:user_addresses) do
      add :user_id, references(:users, [ on_delete: :delete_all, on_update: :update_all ])
      add :name, :string
      add :recipient, :string
      add :first_line, :string
      add :second_line, :string
      add :post_code, :string
      add :town, :string

      timestamps()
    end

  end
end
