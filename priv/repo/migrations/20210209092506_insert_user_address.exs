defmodule KiraBijoux.Repo.Migrations.InsertUserAddress do
  use KiraBijouxWeb, :migration

  def change do
    user1 = Repo.one(from u in User, select: u.id, where: u.mail == "marie-berger@gmail.com")
    user2 = Repo.one(from u in User, select: u.id, where: u.mail == "laurence-marteau@gmail.com")
    user3 = Repo.one(from u in User, select: u.id, where: u.mail == "agnes-king@gmail.com")
    user4 = Repo.one(from u in User, select: u.id, where: u.mail == "bertrand-deportes@gmail.com")
    user5 = Repo.one(from u in User, select: u.id, where: u.mail == "xavier-deportes@gmail.com")
    user6 = Repo.one(from u in User, select: u.id, where: u.mail == "alice-deportes@gmail.com")
    user7 = Repo.one(from u in User, select: u.id, where: u.mail == "kira-bijoux@gmail.com")
    Repo.insert_all(User.Address,
      [ %{user_id: user1, name: "Maison", recipient: "Mme Berger", first_line: "3 rue de la gare", second_line: "", post_code: "75008", town: "Paris", country: "France", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{user_id: user2, name: "Maison", recipient: "Mme Marteau", first_line: "4 rue de la gare", second_line: "", post_code: "75008", town: "Paris", country: "France", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{user_id: user3, name: "Maison", recipient: "Mme King", first_line: "5 rue de la gare", second_line: "", post_code: "75008", town: "Paris", country: "France", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{user_id: user4, name: "Maison", recipient: "M Deportes", first_line: "6 rue de la gare", second_line: "", post_code: "75008", town: "Paris", country: "France", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{user_id: user5, name: "Maison", recipient: "M Deportes", first_line: "7 rue de la gare", second_line: "", post_code: "75008", town: "Paris", country: "France", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{user_id: user6, name: "Maison", recipient: "Mme Deportes", first_line: "8 rue de la gare", second_line: "", post_code: "75008", town: "Paris", country: "France", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{user_id: user7, name: "Maison", recipient: "Mme Kira", first_line: "9 rue de la gare", second_line: "", post_code: "75008", town: "Paris", country: "France", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
  end
end
