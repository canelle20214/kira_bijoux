defmodule KiraBijoux.Repo.Migrations.InsertItemPictures do
  use KiraBijouxWeb, :migration

  def change do
    items = Repo.all(from i in Item, select: i.id, order_by: [asc: :id])
    [ item1 | _ ] = items
    {:ok, item2} = Enum.fetch(items, 1)
    {:ok, item3} = Enum.fetch(items, 2)
    {:ok, item4} = Enum.fetch(items, 3)
    {:ok, item5} = Enum.fetch(items, 4)
    {:ok, item6} = Enum.fetch(items, 5)
    {:ok, item7} = Enum.fetch(items, 6)
    {:ok, item8} = Enum.fetch(items, 7)
    {:ok, item9} = Enum.fetch(items, 8)
    {:ok, item10} = Enum.fetch(items, 9)
    {:ok, item11} = Enum.fetch(items, 10)
    {:ok, item12} = Enum.fetch(items, 11)
    {:ok, item13} = Enum.fetch(items, 12)
    {:ok, item14} = Enum.fetch(items, 13)
    {:ok, item15} = Enum.fetch(items, 14)
    [ item16 | _ ] = Enum.reverse(items)
    Repo.insert_all(Item.Picture,
      [ %{name: "aylee-1.jpg", path: "assets/img/pictures/Aylee/", place: 1, item_id: item1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "aylee-2.jpg", path: "assets/img/pictures/Aylee/", place: 2, item_id: item1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "aylee-3.jpg", path: "assets/img/pictures/Aylee/", place: 3, item_id: item1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "aylee-4.jpg", path: "assets/img/pictures/Aylee/", place: 4, item_id: item1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "aylee-5.jpg", path: "assets/img/pictures/Aylee/", place: 5, item_id: item1, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-1.jpg", path: "assets/img/pictures/Daenerys/", place: 1, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-2.jpg", path: "assets/img/pictures/Daenerys/", place: 2, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-3.jpg", path: "assets/img/pictures/Daenerys/", place: 3, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-4.jpg", path: "assets/img/pictures/Daenerys/", place: 4, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-5.jpg", path: "assets/img/pictures/Daenerys/", place: 5, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-6.jpg", path: "assets/img/pictures/Daenerys/", place: 6, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-7.jpg", path: "assets/img/pictures/Daenerys/", place: 7, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-8.jpg", path: "assets/img/pictures/Daenerys/", place: 8, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-9.jpg", path: "assets/img/pictures/Daenerys/", place: 9, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-10.jpg", path: "assets/img/pictures/Daenerys/", place: 10, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "daenerys-11.jpg", path: "assets/img/pictures/Daenerys/", place: 11, item_id: item2, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "selena-1.jpg", path: "assets/img/pictures/Selena/", place: 1, item_id: item3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "selena-2.jpg", path: "assets/img/pictures/Selena/", place: 2, item_id: item3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "selena-3.jpg", path: "assets/img/pictures/Selena/", place: 3, item_id: item3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "selena-4.jpg", path: "assets/img/pictures/Selena/", place: 4, item_id: item3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "selena-5.jpg", path: "assets/img/pictures/Selena/", place: 5, item_id: item3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "selena-6.jpg", path: "assets/img/pictures/Selena/", place: 6, item_id: item3, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "eden-1.jpg", path: "assets/img/pictures/Eden/", place: 1, item_id: item4, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "eden-2.jpg", path: "assets/img/pictures/Eden/", place: 2, item_id: item4, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "eden-3.jpg", path: "assets/img/pictures/Eden/", place: 3, item_id: item4, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "eden-4.jpg", path: "assets/img/pictures/Eden/", place: 4, item_id: item4, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "isis-1.jpg", path: "assets/img/pictures/Isis/", place: 1, item_id: item5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "isis-2.jpg", path: "assets/img/pictures/Isis/", place: 2, item_id: item5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "isis-3.jpg", path: "assets/img/pictures/Isis/", place: 3, item_id: item5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "isis-4.jpg", path: "assets/img/pictures/Isis/", place: 4, item_id: item5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "isis-5.jpg", path: "assets/img/pictures/Isis/", place: 5, item_id: item5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "isis-6.jpg", path: "assets/img/pictures/Isis/", place: 6, item_id: item5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "isis-7.jpg", path: "assets/img/pictures/Isis/", place: 7, item_id: item5, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "vahalla-1.jpg", path: "assets/img/pictures/Vahalla/", place: 1, item_id: item6, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "vahalla-2.jpg", path: "assets/img/pictures/Vahalla/", place: 2, item_id: item6, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "vahalla-3.jpg", path: "assets/img/pictures/Vahalla/", place: 3, item_id: item6, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "tanya-1.jpg", path: "assets/img/pictures/Tanya/", place: 1, item_id: item7, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "tanya-2.jpg", path: "assets/img/pictures/Tanya/", place: 2, item_id: item7, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "tanya-3.jpg", path: "assets/img/pictures/Tanya/", place: 3, item_id: item7, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "tanya-4.jpg", path: "assets/img/pictures/Tanya/", place: 4, item_id: item7, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "tanya-5.jpg", path: "assets/img/pictures/Tanya/", place: 5, item_id: item7, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "tanya-6.jpg", path: "assets/img/pictures/Tanya/", place: 6, item_id: item7, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amazonite-1.jpg", path: "assets/img/pictures/Kena/", place: 1, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amazonite-2.jpg", path: "assets/img/pictures/Kena/", place: 2, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amazonite-3.jpg", path: "assets/img/pictures/Kena/", place: 3, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amazonite-4.jpg", path: "assets/img/pictures/Kena/", place: 4, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amazonite-5.jpg", path: "assets/img/pictures/Kena/", place: 5, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amazonite-6.jpg", path: "assets/img/pictures/Kena/", place: 6, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amazonite-7.jpg", path: "assets/img/pictures/Kena/", place: 7, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-1.jpg", path: "assets/img/pictures/Kena/", place: 8, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-2.jpg", path: "assets/img/pictures/Kena/", place: 9, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-3.jpg", path: "assets/img/pictures/Kena/", place: 10, item_id: item8, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-pierre-de-lune-1.jpg", path: "assets/img/pictures/Kena/", place: 1, item_id: item9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-pierre-de-lune-2.jpg", path: "assets/img/pictures/Kena/", place: 2, item_id: item9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-pierre-de-lune-3.jpg", path: "assets/img/pictures/Kena/", place: 3, item_id: item9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-pierre-de-lune-4.jpg", path: "assets/img/pictures/Kena/", place: 4, item_id: item9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-pierre-de-lune-5.jpg", path: "assets/img/pictures/Kena/", place: 5, item_id: item9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-1.jpg", path: "assets/img/pictures/Kena/", place: 6, item_id: item9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-2.jpg", path: "assets/img/pictures/Kena/", place: 7, item_id: item9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-3.jpg", path: "assets/img/pictures/Kena/", place: 8, item_id: item9, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-quartz-rose-1.jpg", path: "assets/img/pictures/Kena/", place: 1, item_id: item10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-quartz-rose-2.jpg", path: "assets/img/pictures/Kena/", place: 2, item_id: item10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-quartz-rose-3.jpg", path: "assets/img/pictures/Kena/", place: 3, item_id: item10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-quartz-rose-4.jpg", path: "assets/img/pictures/Kena/", place: 4, item_id: item10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-quartz-rose-5.jpg", path: "assets/img/pictures/Kena/", place: 5, item_id: item10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-quartz-rose-6.jpg", path: "assets/img/pictures/Kena/", place: 6, item_id: item10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-1.jpg", path: "assets/img/pictures/Kena/", place: 9, item_id: item10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-2.jpg", path: "assets/img/pictures/Kena/", place: 10, item_id: item10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-3.jpg", path: "assets/img/pictures/Kena/", place: 11, item_id: item10, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amethyste-1.jpg", path: "assets/img/pictures/Kena/", place: 1, item_id: item11, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amethyste-2.jpg", path: "assets/img/pictures/Kena/", place: 2, item_id: item11, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amethyste-3.jpg", path: "assets/img/pictures/Kena/", place: 3, item_id: item11, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amethyste-4.jpg", path: "assets/img/pictures/Kena/", place: 4, item_id: item11, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-amethyste-5.jpg", path: "assets/img/pictures/Kena/", place: 5, item_id: item11, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-1.jpg", path: "assets/img/pictures/Kena/", place: 6, item_id: item11, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-2.jpg", path: "assets/img/pictures/Kena/", place: 7, item_id: item11, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-all-3.jpg", path: "assets/img/pictures/Kena/", place: 8, item_id: item11, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-labradorite-1.jpg", path: "assets/img/pictures/Kena/", place: 1, item_id: item12, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-labradorite-2.jpg", path: "assets/img/pictures/Kena/", place: 2, item_id: item12, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-labradorite-3.jpg", path: "assets/img/pictures/Kena/", place: 3, item_id: item12, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-labradorite-4.jpg", path: "assets/img/pictures/Kena/", place: 4, item_id: item12, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-lapis-lazuli-1.jpg", path: "assets/img/pictures/Kena/", place: 1, item_id: item13, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-lapis-lazuli-2.jpg", path: "assets/img/pictures/Kena/", place: 2, item_id: item13, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-lapis-lazuli-3.jpg", path: "assets/img/pictures/Kena/", place: 3, item_id: item13, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "kena-lapis-lazuli-4.jpg", path: "assets/img/pictures/Kena/", place: 4, item_id: item13, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "meredith-1.jpg", path: "assets/img/pictures/Meredith/", place: 1, item_id: item14, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "meredith-2.jpg", path: "assets/img/pictures/Meredith/", place: 2, item_id: item14, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "meredith-3.jpg", path: "assets/img/pictures/Meredith/", place: 3, item_id: item14, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "meredith-4.jpg", path: "assets/img/pictures/Meredith/", place: 4, item_id: item14, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "marie-1.jpg", path: "assets/img/pictures/Marie/", place: 1, item_id: item15, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "marie-2.jpg", path: "assets/img/pictures/Marie/", place: 2, item_id: item15, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "marie-3.jpg", path: "assets/img/pictures/Marie/", place: 3, item_id: item15, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-1.jpg", path: "assets/img/pictures/Shana/", place: 1, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-2.jpg", path: "assets/img/pictures/Shana/", place: 2, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-3.jpg", path: "assets/img/pictures/Shana/", place: 3, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-4.jpg", path: "assets/img/pictures/Shana/", place: 4, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-5.jpg", path: "assets/img/pictures/Shana/", place: 5, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-6.jpg", path: "assets/img/pictures/Shana/", place: 6, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-7.jpg", path: "assets/img/pictures/Shana/", place: 7, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-8.jpg", path: "assets/img/pictures/Shana/", place: 8, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-9.jpg", path: "assets/img/pictures/Shana/", place: 9, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)},
      %{name: "shana-10.jpg", path: "assets/img/pictures/Shana/", place: 10, item_id: item16, inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
      ]
    )
  end
end
