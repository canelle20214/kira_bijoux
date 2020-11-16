defmodule KiraBijouxWeb.UserView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{user: user}) do
    conn
    # |> put_req_header("sid", sid)
    |> json(user)
  end

  def render(conn, "show.json", %{user: user}) do
    conn
    |> json(user)
  end

  def render(conn, "index.json", %{users: users}) do
    conn
    |> json(users)
  end

end
