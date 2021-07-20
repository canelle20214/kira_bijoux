defmodule KiraBijouxWeb.OrderStatusView do
  use KiraBijouxWeb, :view

  def render(conn, "show.json", %{order_status: order_status}) do
    conn
    |> json(order_status_construction(order_status))
  end

  def render(conn, "index.json", %{list_of_order_status: list_of_order_status}) do
    list_of_order_status = Enum.map(list_of_order_status, & order_status_construction(&1))
    conn
    |> json(list_of_order_status)
  end

  def order_status_construction(order_status) do
    Map.new(id: order_status.id)
    |> Map.put(:name, order_status.name)
    |> Map.put(:inserted_at, order_status.inserted_at)
    |> Map.put(:updated_at, order_status.updated_at)
  end
end
