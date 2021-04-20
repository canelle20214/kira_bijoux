defmodule KiraBijouxWeb.OrderController do
  use KiraBijouxWeb, :controller

  # get all orders
  swagger_path :index do
    get("/orders")
    summary("Get all orders")
    description("List of orders")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    orders = Repo.all(from o in Order, select: o)
    put_status(conn, 200)
    |> OrderView.render("index.json", %{orders: orders})
  end

  def swagger_definitions do
    %{
      order: swagger_schema do
        title "Order"
        description "Order descr"
        properties do
          order_status_id :integer, "Order status id"
          user_address_id :integer, "User address id"
          payment_type_id :integer, "Payment type id"
          reference :string, "Reference"
          price :number, "Price"
          send_at :string, "Send at in YYYY-MM-DD hh:mm:ss format", format: "ISO-8601"# Date.from_iso8601/1
          received_at :string, "Received at in YYYY-MM-DD hh:mm:ss format", format: "ISO-8601"# Date.from_iso8601/1
        end
      end
    }
  end

  # create order
  swagger_path :create do
    post("/orders")
    summary("Create order")
    description("Create a new order")
    parameter :order, :body, Schema.ref(:order), "Order", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
          order_status_id: 3,
          user_address_id: 1,
          payment_type_id: 1,
          reference: "KB-20210417",
          price: 43.57,
          send_at: "2020-01-27",
          received_at: "2020-02-04"
        })
    produces "application/json"
    response(200, "OK", Schema.ref(:order),
      example:
      %{
        order:
        %{
          order_status_id: 3,
          user_address_id: 1,
          payment_type_id: 1,
          reference: "KB-20210417",
          price: 43.57,
          send_at: "2020-01-27",
          received_at: "2020-02-04"
        }
      }
    )
  end

  def create(conn, params) do
    order_status_id = params["order_status_id"]
    user_address_id = params["user_address_id"]
    payment_type_id = params["payment_type_id"]
    reference = params["reference"]
    price = params["price"]
    send_at = case NaiveDateTime.from_iso8601(params["send_at"]) do
      {:ok, send_at} -> send_at
      {:error, _} -> nil
    end
    received_at = case NaiveDateTime.from_iso8601(params["received_at"]) do
      {:ok, received_at} -> received_at
      {:error, _} -> nil
    end
    case Repo.insert %Order{order_status_id: order_status_id, user_address_id: user_address_id, payment_type_id: payment_type_id, reference: reference, price: price, send_at: send_at, received_at: received_at} do
      {:ok, order} ->
        put_status(conn, 201)
        |> OrderView.render("index.json", %{order: order})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # get order by id
  swagger_path :show do
    get("/orders/{id}")
    summary("Get order by id")
    description("Order filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)
    put_status(conn, 200)
    |> OrderView.render("index.json", %{order: order})
  end


  # get order by user
  swagger_path :showByUserId do
    get("/orders/user/{id}")
    summary("Get order by user id")
    description("Order filtered by user_id")
    parameter :id, :path, :integer, "Id of user's orders to be displayed", required: true
    response(code(:ok), "Success")
  end

  def showByUserId(conn, %{"id" => id}) do
    orders = Repo.all(from o in Order, select: o,
      join: us in User.Address, on: o.user_address_id == us.id,
      where: us.user_id == ^id)
    if orders == [] do
      Logger.error("aucun orders trouver")
      put_status(conn, 404)
      |> json([])
    else
      Logger.info("recherche orders en cours")
      put_status(conn, 200)
      |> OrderView.render("index.json", %{orders: orders})
    end
  end


  # update order
  swagger_path :update do
    put("/orders/{id}")
    summary("Update order")
    description("Update an existing order")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the order to be updated", required: true
    parameter :order, :body, Schema.ref(:order), "Changes in order", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        order_status_id: 3,
        user_address_id: 1,
        payment_type_id: 1,
        reference: "KB-20210417",
        price: 43.57,
        send_at: "2020-01-27",
        received_at: "2020-02-04"
      }
    )
  end

  def update(conn, params) do
    order = Repo.get!(Order, params["id"])
    order_status_id = params["order_status_id"] || order.order_status_id
    user_address_id = params["user_address_id"] || order.user_address_id
    payment_type_id = params["payment_type_id"] || order.payment_type_id
    reference = params["reference"] || order.reference
    price = params["price"] || order.price
    send_at = case NaiveDateTime.from_iso8601(params["send_at"]) do
      {:ok, send_at} -> send_at
      {:error, _} -> nil || order.send_at
    end
    received_at = case NaiveDateTime.from_iso8601(params["received_at"]) do
      {:ok, received_at} -> received_at
      {:error, _} -> nil || order.received_at
    end
    case Repo.update Order.changeset(order, %{order_status_id: order_status_id, user_address_id: user_address_id, payment_type_id: payment_type_id, reference: reference, price: price, send_at: send_at, received_at: received_at}) do
      {:ok, order} ->
        put_status(conn, 200)
        |> OrderView.render("index.json", %{order: order})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # delete order
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/orders/{id}")
    summary("Delete Order")
    description("Delete a Order by id")
    parameter :id, :path, :integer, "The id of the order to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete Repo.get!(Order, id) do
      {:ok, order} ->
        #Phoenix.json/2 cannot render 204 status https://git.pleroma.social/pleroma/pleroma/-/issues/2029
        put_status(conn, 200)
        |> OrderView.render("index.json", %{order: order})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
