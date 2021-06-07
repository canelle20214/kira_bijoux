defmodule KiraBijoux.Repo.Migrations.InsertOrders do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(Order,
      [ %{order_status_id: 1, user_address_id: 1, payment_type_id: 1, price: 159.00, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
        %{order_status_id: 1, user_address_id: 2, payment_type_id: 1, price: 161.00, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
        %{order_status_id: 1, user_address_id: 3, payment_type_id: 1, price: 204.00, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
    # order1: 159 TTC, 127.2 HT, 31.8 TVA
    # order2: 161 TTC, 128.8 HT, 32.2 TVA
    # order3: 204 TTC, 163.2 HT, 40.8 TVA
  end
end
