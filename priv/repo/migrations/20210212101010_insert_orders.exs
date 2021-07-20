defmodule KiraBijoux.Repo.Migrations.InsertOrders do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(Order,
      [
        %{order_status_id: 2, user_address_id: 1, payment_type_id: 1, price: 77.00, inserted_at: ~N[2021-05-21 07:56:40], updated_at: ~N[2021-05-21 07:56:40]},
        %{order_status_id: 6, user_address_id: 2, payment_type_id: 1, price: 113.00, inserted_at: ~N[2021-02-27 18:29:05], updated_at: ~N[2021-03-12 10:28:31]},
        %{order_status_id: 5, user_address_id: 3, payment_type_id: 1, price: 45.00, inserted_at: ~N[2021-06-02 12:01:27], updated_at: ~N[2021-06-16 08:46:09]},
        %{order_status_id: 1, user_address_id: 1, payment_type_id: 1, price: 159.00, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
        %{order_status_id: 1, user_address_id: 2, payment_type_id: 1, price: 161.00, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
        %{order_status_id: 1, user_address_id: 3, payment_type_id: 1, price: 204.00, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
    # order1: 77 TTC, 61.6 HT, 15.4 TVA
    # order2: 113 TTC, 90.4 HT, 22.6 TVA
    # order3: 45 TTC, 36 HT, 9 TVA
    # order4: 159 TTC, 127.2 HT, 31.8 TVA
    # order5: 161 TTC, 128.8 HT, 32.2 TVA
    # order6: 204 TTC, 163.2 HT, 40.8 TVA
  end
end
