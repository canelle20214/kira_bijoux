defmodule KiraBijoux.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_role_id, references(:user_roles, [ on_delete: :delete_all, on_update: :update_all ])
      add :firstname, :string
      add :lastname, :string
      add :mail, :string
      add :password, :string
      add :phone, :string

      timestamps()
    end

  end
end
