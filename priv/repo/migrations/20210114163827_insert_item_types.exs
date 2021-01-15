defmodule KiraBijoux.Repo.Migrations.InsertItemTypes do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert(%Item.Type{name: "Collier"})
    Repo.insert(%Item.Type{name: "Bracelet"})
    Repo.insert(%Item.Type{name: "BO"})
  end
end
