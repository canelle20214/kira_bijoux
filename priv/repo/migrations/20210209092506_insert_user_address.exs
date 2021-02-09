defmodule KiraBijoux.Repo.Migrations.InsertUserAddress do
  use KiraBijouxWeb, :migration

  def change do
    user1 = Repo.one(from u in User, select: u.id, where: u.mail == "test@test.com")
    user2 = Repo.one(from u in User, select: u.id, where: u.mail == "toto@toto.com")
    user3 = Repo.one(from u in User, select: u.id, where: u.mail == "tonton@tonton.com")
    user4 = Repo.one(from u in User, select: u.id, where: u.mail == "admin@gmail.com")
    Repo.insert_all(User.Address,
      [ %{user_id: user1, name: "Maison", recipient: "M Dupont", first_line: "3 rue de la gare", second_line: "", post_code: "75008", town: "Paris", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{user_id: user2, name: "Maison", recipient: "Mme Dupont", first_line: "3 rue de la gare", second_line: "", post_code: "75008", town: "Paris", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{user_id: user3, name: "Maison", recipient: "M Tonton", first_line: "5 rue de la gare", second_line: "", post_code: "75008", town: "Paris", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{user_id: user4, name: "Maison", recipient: "Mme Admin", first_line: "7 rue de la gare", second_line: "", post_code: "75008", town: "Paris", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
  end
end
