defmodule KiraBijoux.Repo.Migrations.InsertMaterialItems do
  use KiraBijouxWeb, :migration

  def change do
    items = Repo.all(from i in Item, select: i.id, order_by: [asc: :id])
    [item1 | list1] = items
    [item2 | list2] = list1
    [item3 | list3] = list2
    [item4 | list4] = list3
    [item5 | list5] = list4
    [item6 | list6] = list5
    [item7 | list7] = list6
    [item8 | list8] = list7
    [item9 | list9] = list8
    [item10 | list10] = list9
    [item11 | list11] = list10
    [item12 | list12] = list11
    [item13 | list13] = list12
    [item14 | list14] = list13
    [item15 | list15] = list14
    [item16 | _] = list15
    material1 = Repo.one(from m in Material, select: m.id, where: m.name == "Argent 925")
    material2 = Repo.one(from m in Material, select: m.id, where: m.name == "Larvikite")
    material3 = Repo.one(from m in Material, select: m.id, where: m.name == "Lapis Lazuli")
    material4 = Repo.one(from m in Material, select: m.id, where: m.name == "Tourmaline rubellite œil de chat")
    material5 = Repo.one(from m in Material, select: m.id, where: m.name == "Amazonite")
    material6 = Repo.one(from m in Material, select: m.id, where: m.name == "Quartz rose")
    material7 = Repo.one(from m in Material, select: m.id, where: m.name == "Amethyste")
    material8 = Repo.one(from m in Material, select: m.id, where: m.name == "Pierre de lune")
    material9 = Repo.one(from m in Material, select: m.id, where: m.name == "Labradorite")
    material10 = Repo.one(from m in Material, select: m.id, where: m.name == "Jaspe Kambaba")
    Repo.insert_all(Material.Item,
      [ %{item_id: item1, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item2, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item2, material_id: material2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item3, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item4, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item5, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item5, material_id: material3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item6, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item7, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item8, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item8, material_id: material5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item9, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item9, material_id: material8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item10, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item10, material_id: material6, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item11, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item11, material_id: material7, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item12, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item12, material_id: material9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item13, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item13, material_id: material3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item14, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item15, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item15, material_id: material4, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item16, material_id: material1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{item_id: item16, material_id: material10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
  end
end
