defmodule KiraBijoux.Repo.Migrations.InsertUsersTable do
  use Ecto.Migration

  def change do
    execute "INSERT INTO user_roles (id, role, inserted_at, updated_at) VALUES (1, 'user', '17-12-2020', '18-12-2020')"
    execute "INSERT INTO users (firstname, lastname, mail, password, phone, user_role_id, inserted_at, updated_at) VALUES ('test', 'test', 'test@test.com', 'test', '0634896623', 1, '12-12-2020', '12-12-2020')"
    execute "INSERT INTO users (firstname, lastname, mail, password, phone, user_role_id, inserted_at, updated_at) VALUES ('toto', 'toto', 'toto@toto.com', 'toto', '0634896623', 1, '13-12-2020', '13-12-2020')"
    execute "INSERT INTO users (firstname, lastname, mail, password, phone, user_role_id, inserted_at, updated_at) VALUES ('tonton', 'tonton', 'tonton@tonton.com', 'tonton', '0634896623', 1, '14-12-2020', '14-12-2020')"
  end
end
