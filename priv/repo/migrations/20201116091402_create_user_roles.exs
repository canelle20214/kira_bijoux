defmodule KiraBijoux.Repo.Migrations.CreateCreateUserRoles do
  use KiraBijouxWeb, :migration

  def change do
    create table(:user_roles) do
      add :role, :string

      timestamps()
    end

  end
end
