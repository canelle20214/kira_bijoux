defmodule KiraBijoux.Repo do
  use Ecto.Repo,
    otp_app: :kira_bijoux,
    adapter: Ecto.Adapters.Postgres
end
