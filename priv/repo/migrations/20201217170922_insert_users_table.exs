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
      [ %{firstname: "test", lastname: "test", mail: "test@test.com", password: "$2b$12$VrOAz34EBpmMBBZGEpFnw.R2aKwWre5VxiOhi3dcOZO78kI0QOoUG", phone: "0634896623", user_role_id: user_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{firstname: "toto", lastname: "toto", mail: "toto@toto.com", password: "$2b$12$bxqK1p..1zTWutpUk88Fh.mc3e0VzpM0cfHVONDr5oH3IyqZB45ci", phone: "0634896624", user_role_id: user_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{firstname: "tonton", lastname: "tonton", mail: "tonton@tonton.com", password: "$2b$12$BzTCxkGPLlb.D7g7Zs2ZEeWYR5djxelrNE4xUZ.CslLsqaNi37WGO", phone: "0634896625", user_role_id: user_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{firstname: "admin", lastname: "admin", mail: "admin@gmail.com", password: "$2b$12$HRDANPX4lOToCAVzN5.NJ.rkipKHwOdtfjIzVLA1xEi1HKGyHNsZu", phone: "0643869623", user_role_id: admin_role_id, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)} ]
    )
  end
end
