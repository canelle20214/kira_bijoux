defmodule KiraBijoux.Repo.Migrations.InsertPage do
  use KiraBijouxWeb, :migration

  def change do

    Repo.insert_all(Page,
    [
      %{name: "LITHOTHÉRAPIE", visibility: true, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "LA MARQUE", visibility: true, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "CONDITIONS DE RETOUR", visibility: true, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "EXPÉDITION ET LIVRAISON DES COMMANDES", visibility: true, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "ENTRETIEN DES BIJOUX", visibility: true, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "MENTIONS LÉGALES", visibility: true, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
    ]
    )
  end
end
