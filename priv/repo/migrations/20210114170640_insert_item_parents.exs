defmodule KiraBijoux.Repo.Migrations.InsertItemParents do
  use KiraBijouxWeb, :migration

  def change do
    collier = Repo.one(from it in Item.Type, select: it.id, where: it.name == "Collier")
    bracelet = Repo.one(from it in Item.Type, select: it.id, where: it.name == "Bracelet")
    bo = Repo.one(from it in Item.Type, select: it.id, where: it.name == "BO")
    collection = Repo.one(from c in Collection, select: c.id, where: c.name == "Collection 2021")
    Repo.insert_all(Item.Parent,
      [%{name: "Aylee", collection_id: collection, item_type_id: collier, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Daenerys", collection_id: collection, item_type_id: collier, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Selena", collection_id: collection, item_type_id: collier, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Eden", collection_id: collection, item_type_id: collier, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Isis", collection_id: collection, item_type_id: collier, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Vahalla", collection_id: collection, item_type_id: collier, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Tanya", collection_id: collection, item_type_id: collier, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Kena", collection_id: collection, item_type_id: collier, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Meredith", collection_id: collection, item_type_id: bracelet, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "Marie", collection_id: collection, item_type_id: bo, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}]
    )
  end
end
