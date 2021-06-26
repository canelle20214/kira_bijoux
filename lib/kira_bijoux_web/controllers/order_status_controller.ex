defmodule KiraBijouxWeb.OrderStatusController do
  use KiraBijouxWeb, :controller

  # get all order status
  swagger_path :index do
    get("/order-status")
    summary("Get all order status")
    description("List of order status")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
    order_status = Repo.all(from os in Order.Status, select: os)
    put_status(conn, 200)
    |> OrderStatusView.render("index.json", %{order_status: order_status})
  end

  def swagger_definitions do
    %{
      Order_Status: swagger_schema do
        title "Order.Status"
        description "Order.Status descr"
        properties do
          name :string, "Name"
        end
      end
    }
  end

  # get order status by id
  swagger_path :show do
    get("/order-status/{id}")
    summary("Get order status by id")
    description("Order.Status filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.one(from os in Order.Status, select: os, where: os.id == ^id) do
      nil ->
        Logger.error("l'order status n'existe pas")
        put_status(conn, 404)
        |> json("Not found")
      order_statut ->
        put_status(conn, 200)
        |> OrderStatusView.render("index.json", %{order_statut: order_statut})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # create order status
  swagger_path :create do
    post("/order-status")
    summary("Create Order Status")
    description("Create a new Order.Status")
    produces "application/json"
    parameter :order_status, :body, Schema.ref(:Order_Status), "Order_Status", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Envoyée"
    })
    produces "application/json"
    response(201, "Created", Schema.ref(:Order_Status),
      example:
        %{
          name: "Envoyée"
        }
    )
  end

  def create(conn, %{"name" => name}) do
    case Repo.insert %Order.Status{name: name} do
      {:ok, order_statut} ->
        put_status(conn, 201)
        |> OrderStatusView.render("index.json", %{order_statut: order_statut})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # update order status
  swagger_path :update do
    put("/order-status/{id}")
    summary("Update order status")
    description("Update an existing Order.Status")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the order status to be updated", required: true
    parameter :order_status, :body, Schema.ref(:Order_Status), "Changes in order status", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        name: "Envoyée"
      }
    )
    produces "application/json"
    response(200, "OK", Schema.ref(:Order_Status),
      example:
        %{
          name: "Envoyée"
        }
    )
  end

  def update(conn, %{"id" => id, "name" => name}) do
    with order_status = %Order.Status{} <- Repo.get(Order.Status, id),
    {:ok, order_statut} <- Repo.update Order.Status.changeset(order_status, %{name: name}) do
      put_status(conn, 200)
      |> OrderStatusView.render("index.json", %{order_statut: order_statut})
    else
      nil ->
        Logger.error "Le status de la commande n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete order status
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/order-status/{id}")
    summary("Delete order status")
    description("Delete a Order.Status by id")
    parameter :id, :path, :integer, "The id of the order status to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with order_status = %Order.Status{} <- Repo.get(Order.Status, id),
    {:ok, _} <- Repo.delete order_status  do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
      nil ->
        Logger.error "L'order status n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
