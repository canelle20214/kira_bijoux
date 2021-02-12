defmodule KiraBijoux.Repo.Migrations.InsertPaymentTypes do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(Payment.Type,
      [ %{name: "Test", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
  end
end
