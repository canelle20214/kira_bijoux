defmodule KiraBijoux.Repo.Migrations.InsertOrders do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(Order,
      [ %{order_status_id: 1, user_address_id: 1, payment_type_id: 1, price: 10.0, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
        %{order_status_id: 1, user_address_id: 2, payment_type_id: 1, price: 10.0, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
        %{order_status_id: 1, user_address_id: 3, payment_type_id: 1, price: 10.0, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
  end
end
