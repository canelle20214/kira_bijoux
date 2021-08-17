defmodule KiraBijoux.Repo.Migrations.InsertUsersTable do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(User.Role,
      [ %{role: "user", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{role: "admin", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)} ]
    )
    user_role_id = Repo.one(from ur in User.Role, select: ur.id, where: ur.role == "user")
    admin_role_id = Repo.one(from ur in User.Role, select: ur.id, where: ur.role == "admin")
    Repo.insert_all(User,
      [ %{firstname: "marie", lastname: "berger", mail: "marie-berger@gmail.com", password: "$2b$12$bTwspbOiDygf4axbSPaMDOn5MaKBSE4nHhuYmNsfbh3QnnqYihRgO", phone: "0634896623", user_role_id: user_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{firstname: "laurence", lastname: "marteau", mail: "laurence-marteau@gmail.com", password: "$2b$12$BSfJDOkHrBhJbcCjlqVdg.QxdwrDaLPlFDCv7joTT2ctUuGay13IS", phone: "0634896624", user_role_id: user_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{firstname: "agnès", lastname: "king", mail: "agnes-king@gmail.com", password: "$2b$12$PZiHvd0wuMQliHeQ3.76GODsKVvy8GM/egDn.34kCYACEs3Pckn3W", phone: "0634896625", user_role_id: user_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{firstname: "bertrand", lastname: "deportes", mail: "bertrand-deportes@gmail.com", password: "$2b$12$YpeoRil0Hr0f0IomOV7Ozuie0pfEf.81dfp6RYtjznlNQsHu5hu9K", phone: "0634896626", user_role_id: user_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{firstname: "xavier", lastname: "deportes", mail: "xavier-deportes@gmail.com", password: "$2b$12$YpeoRil0Hr0f0IomOV7Ozuie0pfEf.81dfp6RYtjznlNQsHu5hu9K", phone: "0634896627", user_role_id: user_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{firstname: "alice", lastname: "deportes", mail: "alice-deportes@gmail.com", password: "$2b$12$YpeoRil0Hr0f0IomOV7Ozuie0pfEf.81dfp6RYtjznlNQsHu5hu9K", phone: "0634896628", user_role_id: user_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{firstname: "kira", lastname: "kira", mail: "kira-bijoux@gmail.com", password: "$2b$12$lqtw2a4dNBP6AmRtpZV3mu1AFzLInnWm3K3lZO2yyadsYdJMTNGQi", phone: "0643869623", user_role_id: admin_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)} ]
    )
  end
end
