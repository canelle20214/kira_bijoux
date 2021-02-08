defmodule KiraBijouxWeb.OrderView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{order: order}) do
    conn
    |> json(order_construction(order))
  end

  def render(conn, "index.json", %{orders: orders}) do
    orders = Enum.map(orders, & order_construction(&1))
    conn
    |> json(orders)
  end

  def order_construction(order) do
    order_items = Repo.all(from oi in Order.Item, select: oi, where: oi.order_id == ^order.id)
    |> KiraBijouxWeb.OrderItemView.order_item_construction()
    status = Repo.get!(Order.Status, order.order_status_id)
    |> KiraBijouxWeb.OrderStatusView.order_status_construction()
    address = Repo.get!(User.Address, order.user_address_id)
    |> KiraBijouxWeb.UserAddressView.user_address_construction()
    payment_type = Repo.get!(Payment.Type, order.payment_type_id)
    |> KiraBijouxWeb.PaymentTypeView.payment_type_construction()
    Map.new(id: order.id)
    |> Map.put(:address, address)
    |> Map.put(:order_items, order_items)
    |> Map.put(:payment_type, payment_type)
    |> Map.put(:status, status)
    |> Map.put(:price, order.price)
    |> Map.put(:inserted_at, order.inserted_at)
    |> Map.put(:updated_at, order.updated_at)
  end
end
