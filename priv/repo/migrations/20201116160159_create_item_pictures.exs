defmodule KiraBijoux.Repo.Migrations.CreateItemPictures do
  use Ecto.Migration

  def change do
    create table(:item_pictures) do
      add :item_id, references(:items, [ on_delete: :delete_all, on_update: :update_all ])
      add :name, :string
      add :path, :text
      add :place, :integer

      timestamps()
    end

    create index(:item_pictures, [:item_id])
  end
end
