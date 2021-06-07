defmodule KiraBijouxWeb.OrderItemController do
  use KiraBijouxWeb, :controller

  # get all order items
  swagger_path :index do
    get("/order-items")
    summary("Get all order_items")
    description("List of Order.Items")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    order_items = Repo.all(from oi in Order.Item, select: oi)
    put_status(conn, 200)
    |> OrderItemView.render("index.json", %{order_items: order_items})
  end

  def swagger_definitions do
    %{
      order_item: swagger_schema do
        title "Order.Item"
        description "Order.Item descr"
        properties do
          order_id :integer, "Order id"
          quantity :integer, "Quantity"
          item_id :integer, "Item id"
        end
      end
    }
  end

  # create order_item
  swagger_path :create do
    post("/order-items")
    summary("Create order_item")
    description("Create a new Order.Item")
    parameter :order_item, :body, Schema.ref(:order_item), "Order.Item", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
          order_id: 1,
          quantity: 3,
          item_id: 2
        })
    produces "application/json"
    response(201, "OK", Schema.ref(:order_item),
      example:
      %{
        order_item:
        %{
          order_id: 1,
          quantity: 3,
          item_id: 2
        }
      }
    )
  end

  def create(conn, %{"order_id" => order_id, "quantity" => quantity, "item_id" => item_id}) do
    case Repo.insert %Order.Item{order_id: order_id, quantity: quantity, item_id: item_id} do
      {:ok, order_item} ->
        put_status(conn, 201)
        |> OrderItemView.render("index.json", %{order_item: order_item})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get order item by id
  swagger_path :show do
    get("/order-items/{id}")
    summary("Get order_item by id")
    description("Order.Item filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Order.Item, id) do
      nil ->
        Logger.error "L'order_item n'existe pas."
        put_status(conn, 404)
        |> json([])
      order_item ->
        put_status(conn, 200)
        |> OrderItemView.render("index.json", %{order_item: order_item})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get order items by order
  swagger_path :showByOrderId do
    get("/order-items/order/{id}")
    summary("Get order_items by order id")
    description("Order.Item filtered by order_id")
    parameter :id, :path, :integer, "Id of order's order items to be displayed", required: true
    response(code(:ok), "Success")
  end

  def showByOrderId(conn, %{"id" => id}) do
    case Repo.all(from oi in Order.Item, select: oi,
      where: oi.order_id == ^id) do
      [] ->
        Logger.error("aucun order_items trouver")
        put_status(conn, 404)
        |> json([])
      order_items ->
        Logger.info("recherche order_items en cours")
        put_status(conn, 200)
        |> OrderItemView.render("index.json", %{order_items: order_items})
    end
  end
  def showByOrderId(conn, _), do: put_status(conn, 400) |> json("Bad request")


  # update order item
  swagger_path :update do
    put("/order-items/{id}")
    summary("Update order_item")
    description("Update an existing Order.Item")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the order item to be updated", required: true
    parameter :order_item, :body, Schema.ref(:order_item), "Changes in order item", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        order_id: 1,
        quantity: 3,
        item_id: 2
      }
    )
  end

  def update(conn, %{"id" => id} = params) do
    case Repo.get(Order.Item, id) do
      nil ->
        Logger.error "L'order_item n'existe pas."
        put_status(conn, 404)
      order_item ->
        order_id = params["order_id"] || order_item.order_id
        quantity = params["quantity"] || order_item.quantity
        item_id = params["item_id"] || order_item.item_id
        case Repo.update Order.Item.changeset(order_item, %{order_id: order_id, quantity: quantity, item_id: item_id}) do
          {:ok, order_item} ->
            put_status(conn, 200)
            |> OrderItemView.render("index.json", %{order_item: order_item})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete order_item
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/order-items/{id}")
    summary("Delete order_item")
    description("Delete a Order.Item by id")
    parameter :id, :path, :integer, "The id of the order item to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with order_item = %Order.Item{} <- Repo.get(Order.Item, id),
    {:ok, _} <- Repo.delete order_item do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      nil ->
        Logger.error "L'order item n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
