defmodule KiraBijoux.Repo.Migrations.InsertUserNewsletters do
  use KiraBijouxWeb, :migration

  def change do
    newsletter1 = Repo.one(from n in Newsletter, select: n.id, where: n.name == "Newletter")
    newsletter2 = Repo.one(from n in Newsletter, select: n.id, where: n.name == "Alerte stock")
    newsletter3 = Repo.one(from n in Newsletter, select: n.id, where: n.name == "Promo")
    user = Repo.one(from u in User, select: u.id, where: u.mail == "marie-berger@gmail.com")
    mail = "unknown@gmail.com"
    item = Repo.one(from i in Item, select: i.id, where: i.subtitle == "Collier Daenerys en perles de Larvikite")
    Repo.insert_all(User.Newsletter,
    [ %{user_id: user, newsletter_id: newsletter1, mail: nil, item_id: nil, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{user_id: nil, newsletter_id: newsletter2, mail: mail, item_id: item, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
    %{user_id: user, newsletter_id: newsletter3, mail: nil, item_id: nil, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
    ]
  )
  end
end
