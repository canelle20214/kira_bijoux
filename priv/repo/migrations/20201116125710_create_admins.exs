defmodule KiraBijoux.Repo.Migrations.CreateAdmins do
  use KiraBijouxWeb, :migration

  def change do
    create table(:admins) do
      add :login, :string
      add :password, :string

      timestamps()
    end

  end
end
