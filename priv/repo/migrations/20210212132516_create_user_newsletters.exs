defmodule KiraBijoux.Repo.Migrations.CreateUserNewsletters do
  use Ecto.Migration

  def change do
    create table(:user_newsletters) do
      add :user_id, references(:users, [ on_delete: :delete_all, on_update: :update_all ])
      add :newsletter_id, references(:newsletters, [ on_delete: :delete_all, on_update: :update_all ])
      add :mail, :string
      add :item_id, references(:items, [ on_delete: :delete_all, on_update: :update_all ])

      timestamps()
    end
    create constraint(:user_newsletters, :user_newsletters_constraint, check: "(user_id IS NOT NULL) OR (mail IS NOT NULL)")

    create index(:user_newsletters, [:user_id])
    create index(:user_newsletters, [:newsletter_id])
  end
end
