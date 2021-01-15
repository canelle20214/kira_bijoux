defmodule KiraBijoux.Repo.Migrations.InsertMaterialItems do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert(%Material.Item{item_id: 1, material_id: 1})
    Repo.insert(%Material.Item{item_id: 2, material_id: 1})
    Repo.insert(%Material.Item{item_id: 2, material_id: 2})
    Repo.insert(%Material.Item{item_id: 3, material_id: 1})
    Repo.insert(%Material.Item{item_id: 4, material_id: 1})
    Repo.insert(%Material.Item{item_id: 5, material_id: 1})
    Repo.insert(%Material.Item{item_id: 5, material_id: 3})
    Repo.insert(%Material.Item{item_id: 6, material_id: 1})
    Repo.insert(%Material.Item{item_id: 7, material_id: 1})
    Repo.insert(%Material.Item{item_id: 8, material_id: 1})
    Repo.insert(%Material.Item{item_id: 8, material_id: 5})
    Repo.insert(%Material.Item{item_id: 9, material_id: 1})
    Repo.insert(%Material.Item{item_id: 9, material_id: 8})
    Repo.insert(%Material.Item{item_id: 10, material_id: 1})
    Repo.insert(%Material.Item{item_id: 10, material_id: 6})
    Repo.insert(%Material.Item{item_id: 11, material_id: 1})
    Repo.insert(%Material.Item{item_id: 11, material_id: 7})
    Repo.insert(%Material.Item{item_id: 12, material_id: 1})
    Repo.insert(%Material.Item{item_id: 12, material_id: 9})
    Repo.insert(%Material.Item{item_id: 13, material_id: 1})
    Repo.insert(%Material.Item{item_id: 13, material_id: 3})
    Repo.insert(%Material.Item{item_id: 14, material_id: 1})
    Repo.insert(%Material.Item{item_id: 15, material_id: 1})
    Repo.insert(%Material.Item{item_id: 15, material_id: 4})
  end
end
