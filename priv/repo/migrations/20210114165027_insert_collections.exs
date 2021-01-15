defmodule KiraBijoux.Repo.Migrations.InsertCollections do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert(%Collection{name: "Collection 2021"})
  end
end
