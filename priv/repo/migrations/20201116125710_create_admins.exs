defmodule KiraBijoux.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :login, :string
      add :password, :string

      timestamps()
    end

  end
end
