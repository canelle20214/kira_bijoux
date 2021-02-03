defmodule KiraBijoux.Repo.Migrations.InsertUsersTable do
  use KiraBijouxWeb, :migration

  def change do
    execute "INSERT INTO user_roles (id, role, inserted_at, updated_at) VALUES (1, 'user', '17-12-2020', '18-12-2020')"
    execute "INSERT INTO user_roles (id, role, inserted_at, updated_at) VALUES (2, 'admin', '20-12-2020', '21-12-2020')"
    execute "INSERT INTO users (firstname, lastname, mail, password, phone, user_role_id, inserted_at, updated_at) VALUES ('test', 'test', 'test@test.com', '$2b$12$VrOAz34EBpmMBBZGEpFnw.R2aKwWre5VxiOhi3dcOZO78kI0QOoUG', '0634896623', 1, '12-12-2020', '12-12-2020')"
    execute "INSERT INTO users (firstname, lastname, mail, password, phone, user_role_id, inserted_at, updated_at) VALUES ('toto', 'toto', 'toto@toto.com', '$2b$12$bxqK1p..1zTWutpUk88Fh.mc3e0VzpM0cfHVONDr5oH3IyqZB45ci', '0634896624', 1, '13-12-2020', '13-12-2020')"
    execute "INSERT INTO users (firstname, lastname, mail, password, phone, user_role_id, inserted_at, updated_at) VALUES ('tonton', 'tonton', 'tonton@tonton.com', '$2b$12$BzTCxkGPLlb.D7g7Zs2ZEeWYR5djxelrNE4xUZ.CslLsqaNi37WGO', '0634896625', 1, '14-12-2020', '14-12-2020')"
    execute "INSERT INTO users (firstname, lastname, mail, password, phone, user_role_id, inserted_at, updated_at) VALUES ('admin', 'admin', 'admin@gmail.com', '$2b$12$HRDANPX4lOToCAVzN5.NJ.rkipKHwOdtfjIzVLA1xEi1HKGyHNsZu', '0643869623', 2, '15-12-2020', '15-12-2020')"
  end
end
