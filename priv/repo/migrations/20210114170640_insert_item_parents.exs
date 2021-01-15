defmodule KiraBijoux.Repo.Migrations.InsertItemParents do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert(%Item.Parent{name: "Aylee", collection_id: 1, item_type_id: 1})
    Repo.insert(%Item.Parent{name: "Daenerys", collection_id: 1, item_type_id: 1})
    Repo.insert(%Item.Parent{name: "Selena", collection_id: 1, item_type_id: 1})
    Repo.insert(%Item.Parent{name: "Eden", collection_id: 1, item_type_id: 1})
    Repo.insert(%Item.Parent{name: "Isis", collection_id: 1, item_type_id: 1})
    Repo.insert(%Item.Parent{name: "Vahalla", collection_id: 1, item_type_id: 1})
    Repo.insert(%Item.Parent{name: "Tanya", collection_id: 1, item_type_id: 1})
    Repo.insert(%Item.Parent{name: "Kena", collection_id: 1, item_type_id: 1})
    Repo.insert(%Item.Parent{name: "Meredith", collection_id: 1, item_type_id: 2})
    Repo.insert(%Item.Parent{name: "Marie", collection_id: 1, item_type_id: 3})
  end
end
