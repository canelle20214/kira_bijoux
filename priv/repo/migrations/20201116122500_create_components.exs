defmodule KiraBijoux.Repo.Migrations.CreateComponents do
  use Ecto.Migration

  def change do
    create table(:components) do
      add :component_type_id, references(:component_types, [ on_delete: :delete_all, on_update: :update_all ])
      add :name, :string
      add :content, :text

      timestamps()
    end

    create index(:components, [:component_type_id])
  end
end
