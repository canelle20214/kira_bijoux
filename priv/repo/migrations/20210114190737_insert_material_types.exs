defmodule KiraBijoux.Repo.Migrations.InsertMaterialTypes do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(Material.Type,
      [ %{name: "Métaux", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Pierres fines", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)} ]
    )
  end
end
