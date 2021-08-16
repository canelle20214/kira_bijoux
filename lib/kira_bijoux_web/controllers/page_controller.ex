defmodule KiraBijouxWeb.PageController do
  use KiraBijouxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
