defmodule KiraBijoux.Repo.Migrations.CreateUserFavorites do
  use Ecto.Migration

  def change do
    create table(:user_favorites) do
      add :user_id, references(:users, [ on_delete: :delete_all, on_update: :update_all ])
      add :item_id, references(:items, [ on_delete: :delete_all, on_update: :update_all ])

      timestamps()
    end

    create index(:user_favorites, [:user_id])
    create index(:user_favorites, [:item_id])
  end
end
