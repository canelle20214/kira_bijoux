defmodule KiraBijoux.Repo.Migrations.InsertNewsletters do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(Newsletter,
    [ %{name: "Newletter", cc: "Newletter Kira Bijoux 2021", content: "Découvrez nos bijoux...", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Alerte stock", cc: "Alerte stock : Kira Bijoux 2021", content: "L'article {item} est de nouveau disponible !", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{name: "Promo", cc: "Promo Kira Bijoux", content: "Bénéficiez de {promo} de promo sur vos achats en ligne dès maintenant !", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
    ]
  )
  end
end
