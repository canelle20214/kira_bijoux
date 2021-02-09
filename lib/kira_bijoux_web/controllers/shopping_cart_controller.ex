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
    |> OrderItemView.render("index.json", %{order_items: order_items})
  end

  # get shopping cart by user
  swagger_path :show do
    get("/shop/user/{user_id}")
    summary("Get shopping cart by user")
    description("shopping cart filtered by user")
    parameter :user_id, :path, :integer, "The user_id of the shopping cart to be created", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"user_id" => user_id}) do
    user_id = params["user_id"]
    order_id = Repo.one(from o in Order, select: o,
      where: o.user_adress_id == ^user_id)

    order_items = Repo.one(from i in Order.Item, select: i, where: i.order_id = ^order_id)
    if order_items == [] do
      Logger.error("le panier est vide")
      put_status(conn, 404)
      |> json([])
    else
      Logger.info("recherche panier en cours")
      put_status(conn, 200)
      |> ItemView.render("index.json", %{order_items: order_items})
    end
  end

  # add product to shopping cart
  swagger_path :create do
    post("/shop")
    summary("Create shopping cart")
    description("Create a new shopping cart")
    produces "application/json"
    parameters do
      item_id :query, :integer, "The item_id of the shopping cart to be created", required: true
      user_id :query, :integer, "The user_id of the shopping cart to be created", required: true
      quantity :query, :integer, "The quantity of the shopping cart to be created", required: true
    end
  end

  def create(conn, params) do
    item_id = params["item_id"]
    user_id = params["user_id"]
    quantity = params["quantity"]
    order_id = Repo.one(from o in Order, select: o,
      where: o.user_adress_id == ^user_id)
    case Repo.insert %Order.Item{item_id: item_id, order_id: order_id, quantity: quantity} do
    {:ok, order_items} ->
      put_status(conn, 201)
      |> KiraBijouxWeb.OrderItemView.render("index.json", %{order_items: order_items})
    {:error, changeset} ->
      Logger.error changeset
      put_status(conn, 500)
    end
  end
end
