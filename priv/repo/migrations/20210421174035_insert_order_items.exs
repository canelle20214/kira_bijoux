defmodule KiraBijoux.Repo.Migrations.InsertOrderItems do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert_all(Order.Item,
      [ %{order_id: 1, item_id: 1, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 1, item_id: 7, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 1, item_id: 14, quantity: 2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{order_id: 1, item_id: 16, quantity: 1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
  end
end
