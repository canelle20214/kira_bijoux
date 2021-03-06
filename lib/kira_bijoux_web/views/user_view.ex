defmodule KiraBijouxWeb.UserView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{user: user}) do
    conn
    |> json(user_construction(user))
  end

  def render(conn, "index.json", %{users: users}) do
    users = Enum.map(users, & user_construction(&1))
    conn
    |> json(users)
  end

  def user_construction(user) do
    addresses = Repo.all(from ua in User.Address, select: ua, where: ua.user_id == ^user.id)
    |> Enum.map(&KiraBijouxWeb.UserAddressView.user_address_construction(&1))
    role = Repo.get!(User.Role, user.user_role_id)
    |> KiraBijouxWeb.UserRoleView.user_role_construction()
    Map.new(id: user.id)
    |> Map.put(:firstname, user.firstname)
    |> Map.put(:lastname, user.lastname)
    |> Map.put(:mail, user.mail)
    |> Map.put(:password, user.password)
    |> Map.put(:phone, user.phone)
    |> Map.put(:addresses, addresses)
    |> Map.put(:role, role)
    |> Map.put(:inserted_at, user.inserted_at)
    |> Map.put(:updated_at, user.updated_at)
  end
end
