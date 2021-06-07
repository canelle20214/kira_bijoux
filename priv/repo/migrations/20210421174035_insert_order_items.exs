defmodule KiraBijoux.Repo.Migrations.InsertOrderItems do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(Order.Item,
      [ %{order_id: 1, item_id: 1, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 1, item_id: 3, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 1, item_id: 7, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 1, item_id: 10, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 2, item_id: 5, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 2, item_id: 12, quantity: 2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 2, item_id: 15, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 3, item_id: 4, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 3, item_id: 8, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 3, item_id: 9, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 3, item_id: 14, quantity: 3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
    # order1: 159 TTC, 127.2 HT, 31.8 TVA
    # order2: 161 TTC, 128.8 HT, 32.2 TVA
    # order3: 204 TTC, 163.2 HT, 40.8 TVA
  end
end
