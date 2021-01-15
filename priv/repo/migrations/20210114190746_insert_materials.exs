defmodule KiraBijoux.Repo.Migrations.InsertMaterials do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert(%Material{name: "Argent 925", material_type_id: 1})
    Repo.insert(%Material{name: "Larvikite", material_type_id: 2})
    Repo.insert(%Material{name: "Lapis Lazuli", material_type_id: 2})
    Repo.insert(%Material{name: "tourmaline rubellite œil de chat", material_type_id: 2})
    Repo.insert(%Material{name: "Amazonite", material_type_id: 2})
    Repo.insert(%Material{name: "Quartz rose", material_type_id: 2})
    Repo.insert(%Material{name: "Amethyste", material_type_id: 2})
    Repo.insert(%Material{name: "Pierre de lune", material_type_id: 2})
    Repo.insert(%Material{name: "Labradorite", material_type_id: 2})
  end
end
