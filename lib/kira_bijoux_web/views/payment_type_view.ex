defmodule KiraBijouxWeb.PaymentTypeView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{payment_type: payment_type}) do
    conn
    |> json(payment_type_construction(payment_type))
  end

  def render(conn, "index.json", %{payment_types: payment_types}) do
    payment_types = Enum.map(payment_types, & payment_type_construction(&1))
    conn
    |> json(payment_types)
  end

  def payment_type_construction(payment_type) do
    Map.new(id: payment_type.id)
    |> Map.put(:name, payment_type.name)
    |> Map.put(:inserted_at, payment_type.inserted_at)
    |> Map.put(:updated_at, payment_type.updated_at)
  end
end
