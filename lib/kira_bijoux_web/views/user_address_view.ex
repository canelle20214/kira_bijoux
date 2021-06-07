defmodule KiraBijouxWeb.UserAddressView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{user_address: user_address}) do
    conn
    |> json(user_address_construction(user_address))
  end

  def render(conn, "index.json", %{user_addresses: user_addresses}) do
    user_addresss = Enum.map(user_addresses, & user_address_construction(&1))
    conn
    |> json(user_addresss)
  end

  def user_address_construction(user_address) do
    Map.new(id: user_address.id)
    |> Map.put(:user, user_address.user_id)
    |> Map.put(:name, user_address.name)
    |> Map.put(:recipient, user_address.recipient)
    |> Map.put(:first_line, user_address.first_line)
    |> Map.put(:second_line, user_address.second_line)
    |> Map.put(:post_code, user_address.post_code)
    |> Map.put(:town, user_address.town)
    |> Map.put(:country, user_address.country)
    |> Map.put(:inserted_at, user_address.inserted_at)
    |> Map.put(:updated_at, user_address.updated_at)
  end
end
