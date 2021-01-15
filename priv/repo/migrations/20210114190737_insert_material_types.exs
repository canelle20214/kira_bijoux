defmodule KiraBijoux.Repo.Migrations.InsertMaterialTypes do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert(%Material.Type{name: "Métaux"})
    Repo.insert(%Material.Type{name: "Pierres fines"})
  end
end
