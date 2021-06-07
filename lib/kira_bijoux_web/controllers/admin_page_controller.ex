defmodule KiraBijouxWeb.AdminPageController do
  use KiraBijouxWeb, :controller

  def index(conn, _) do
    render(conn, "index.html")
  end
end
