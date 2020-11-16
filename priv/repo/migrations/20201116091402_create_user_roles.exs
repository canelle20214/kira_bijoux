defmodule KiraBijoux.Repo.Migrations.CreateCreateUserRoles do
  use Ecto.Migration

  def change do
    create table(:user_roles) do
      add :role, :string

      timestamps()
    end

  end
end
