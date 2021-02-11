defmodule KiraBijouxWeb.OrderItemView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{order_item: order_item}) do
    conn
    |> json(order_item_construction(order_item))
  end

  def render(conn, "index.json", %{order_items: order_items}) do
    order_items = Enum.map(order_items, & order_item_construction(&1))
    conn
    |> json(order_items)
  end

  def order_item_construction(order_item) do
    item = Repo.get!(Item, order_item.item_id)
    |> KiraBijouxWeb.ItemView.item_construction()
    Map.new(id: order_item.id)
    |> Map.put(:item, item)
    |> Map.put(:quantity, order_item.quantity)
    |> Map.put(:inserted_at, order_item.inserted_at)
    |> Map.put(:updated_at, order_item.updated_at)
  end
end
