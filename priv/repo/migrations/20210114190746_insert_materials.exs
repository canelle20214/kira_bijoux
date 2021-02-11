defmodule KiraBijoux.Repo.Migrations.InsertMaterials do
  use KiraBijouxWeb, :migration

  def change do
    metal = Repo.one(from mt in Material.Type, select: mt.id, where: mt.name == "Métaux")
    pierre = Repo.one(from mt in Material.Type, select: mt.id, where: mt.name == "Pierres fines")
    Repo.insert_all(Material,
      [ %{name: "Argent 925", material_type_id: metal, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Larvikite", material_type_id: pierre, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Lapis Lazuli", material_type_id: pierre, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Tourmaline rubellite œil de chat", material_type_id: pierre, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Amazonite", material_type_id: pierre, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Quartz rose", material_type_id: pierre, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Amethyste", material_type_id: pierre, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Pierre de lune", material_type_id: pierre, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Labradorite", material_type_id: pierre, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)} ]
    )
  end
end
