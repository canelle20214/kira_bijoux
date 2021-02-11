defmodule KiraBijoux.Repo.Migrations.InsertItems do
  use KiraBijouxWeb, :migration

  def change do
    item1 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Aylee")
    item2 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Daenerys")
    item3 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Selena")
    item4 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Eden")
    item5 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Isis")
    item6 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Vahalla")
    item7 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Tanya")
    item8 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Kena")
    item9 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Meredith")
    item10 = Repo.one(from it in Item.Parent, select: it.id, where: it.name == "Marie")
    Repo.insert_all(Item,
      [ %{item_parent_id: item1, price: 37.00, stock: 5, visibility: true, description: "Ras le cou Pique \n35 cm + 5 cm extension", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item2, price: 68.00, stock: 0, visibility: true, description: "Collier perles \n37 cm + 5 cm extension", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item3, price: 38.00, stock: 10, visibility: true, description: "Collier pendentuf lune \n38 cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item4, price: 42.00, stock: 10, visibility: true, description: "Collier pendentif flèche \n38 cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item5, price: 45.00, stock: 10, visibility: true, description: "Collier pendentif pierre \n40 cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item6, price: 42.00, stock: 0, visibility: true, description: "Collier pendentif médaille ajourée \n40 cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item7, price: 39.00, stock: 1, visibility: true, description: "Collier pendentif médaille martelée \n45 cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item8, price: 45.00, stock: 4, visibility: true, description: "Collier pendentif pierre \n50cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item8, price: 45.00, stock: 6, visibility: true, description: "Collier pendentif pierre \n50cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item8, price: 45.00, stock: 6, visibility: true, description: "Collier pendentif pierre \n50cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item8, price: 45.00, stock: 0, visibility: true, description: "Collier pendentif pierre \n50cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item8, price: 45.00, stock: 0, visibility: true, description: "Collier pendentif pierre \n50cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item8, price: 45.00, stock: 1, visibility: true, description: "Collier pendentif pierre \n50cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item9, price: 24.00, stock: 5, visibility: true, description: "Médaille martelée \n17,5 cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_parent_id: item10, price: 26.00, stock: 2, visibility: true, description: "Pendants Œil de chat \n2 cm", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)} ]
    )

  end
end
