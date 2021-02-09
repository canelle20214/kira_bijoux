defmodule KiraBijouxWeb.ShoppingCartController do
  import Plug.Conn.Status, only: [code: 1]
  use KiraBijouxWeb, :controller
  use PhoenixSwagger

  # get all shopping cart
  swagger_path :index do
    get("/shop")
    summary("Get all shopping cart")
    description("List of shopping cart")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
    order_items = Repo.all(from i in Order.Item, select: i)
    put_status(conn, 200)
    |> ItemView.render("index.json", %{order_items: order_items})
  end

  # get shopping cart by user
  swagger_path :showByName do
    get("/shop/user/{name}")
    summary("Get shopping cart by user")
    description("shopping cart filtered by user")
    response(code(:ok), "Success")
  end

  def showByName(conn, %{"name" => name}) do
  end

  # create shopping cart
  swagger_path :create do
    post("/shop")
    summary("Create shopping cart")
    description("Create a new shopping cart")
    produces "application/json"
  end

  def create(conn, params) do
  end
end
