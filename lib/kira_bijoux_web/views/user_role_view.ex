defmodule KiraBijouxWeb.UserRoleView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{user_role: user_role}) do
    conn
    |> json(user_role_construction(user_role))
  end

  def render(conn, "index.json", %{user_roles: user_roles}) do
    user_roles = Enum.map(user_roles, & user_role_construction(&1))
    conn
    |> json(user_roles)
  end

  def user_role_construction(user_role) do
    Map.new(id: user_role.id)
    |> Map.put(:role, user_role.role)
    |> Map.put(:inserted_at, user_role.inserted_at)
    |> Map.put(:updated_at, user_role.updated_at)
  end
end
