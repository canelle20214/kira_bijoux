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
    |> KiraBijouxWeb.OrderItemView.render("index.json", %{order_items: order_items})
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
    order_id = Repo.one(from o in Order, select: o,
      where: o.user_address_id == ^user_id)
    order_items = Repo.all(from i in Order.Item, select: i, where: i.order_id == ^order_id.id)
    if order_items == nil do
      Logger.error("le panier est vide")
      put_status(conn, 404)
      |> json([])
    else
      Logger.info("recherche panier en cours")
      put_status(conn, 200)
      |> KiraBijouxWeb.OrderItemView.render("index.json", %{order_items: order_items})
    end
  end

  def swagger_definitions do
    %{
      Shop: swagger_schema do
        title "Shop"
        description "Shop descr"
        properties do
          item_id :integer, "Item id"
          user_id :integer, "User id"
          quantity :integer, "Quantity"
        end
      end
    }
  end

  # add product to shopping cart
  swagger_path :create do
    post("/shop")
    summary("Create shopping cart")
    description("Create a new shopping cart")
    produces "application/json"
    parameter :shop, :body, Schema.ref(:Shop), "Shop", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      item_id: 1,
      user_id: 1,
      quantity: 1
    })
  end

  def create(conn, params) do
    item_id = params["item_id"]
    user_id = params["user_id"]
    quantity = params["quantity"]

    # on vérifie si l'item n'est pas déjà présent dans le panier de l'utilisateur
    order_id = Repo.one(from o in Order, select: o,
      where: o.user_address_id == ^user_id)
    order_items = Repo.all(from i in Order.Item, select: i, where: i.order_id == ^order_id.id)

    # on parcours tous les items présents dans le panier de l'utilisateur
    Enum.map(order_items, fn x ->
      # si l'item est déjà présent dans le panier alors on fait un update de la quantité de l'item
      # en lui passant la somme de l'ancienne quantité et de la nouvelle
      if x.item_id == item_id do
        quantity = x.quantity + quantity
        # on vérifie si la nouvelle quantité est supérieur aux nombre d'items en stock pour cet item
        item_stock = Repo.one(from i in Item, select: i.stock, where: i.id == ^item_id)
        if quantity > item_stock do
          Logger.error("la quantite saisi est incorrecte")
          put_status(conn, 404)
          |> json([])
          exit(:shutdown)
        else
          order_item = x
          |> KiraBijoux.Order.Item.changeset(%{quantity: quantity})
          case Repo.update order_item do
            {:ok, order_item} ->
              # si on n'a pas d'erreur alors on modifie l'item du panier et on sort de la fonction
              # avec exit() afin de ne pas éxécuter la suite du code de la fonction
              put_status(conn, 200)
              |> KiraBijouxWeb.OrderItemView.render("index.json", %{order_item: order_item})
              exit(:shutdown)
            {:error, changeset} ->
              Logger.error changeset
              put_status(conn, 500)
              exit(:shutdown)
          end
        end
      end
    end)

    # on vérifie si la quantité saisi est supérieur aux nombre d'items en stock pour cet item
    item_stock = Repo.one(from i in Item, select: i.stock, where: i.id == ^item_id)
    if quantity > item_stock do
      Logger.error("la quantité saisi est incorrecte")
      put_status(conn, 404)
      |> json([])
    else
      # si on n'a pas d'erreur alors on ajoute l'item au panier
      order_id = Repo.one(from o in Order, select: o, where: o.user_address_id == ^user_id)
      case Repo.insert %Order.Item{order_id: order_id.id, item_id: item_id, quantity: quantity} do
      {:ok, order_item} ->
        put_status(conn, 201)
        |> KiraBijouxWeb.OrderItemView.render("index.json", %{order_item: order_item})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
      end
    end
  end

  # update quantity of item of shopping cart
  swagger_path :update do
    put("/shop/{item_id}/{user_id}")
    summary("Update quantity of shopping cart")
    description("Update an existing shopping cart")
    produces "application/json"
    parameter :item_id, :path, :integer, "The id of the item of the shopping cart to be updated", required: true
    parameter :shop, :body, Schema.ref(:Shop), "Shop", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      user_id: 1,
      quantity: 2
    })
  end

  def update(conn, %{"item_id" => item_id, "user_id" => user_id, "quantity" => quantity}) do
    item_stock = Repo.one(from i in Item, select: i.stock, where: i.id == ^item_id)
    if quantity > item_stock do
      Logger.error("la quantité est incorrecte")
      put_status(conn, 404)
      |> json([])
    else
      order_item = Repo.one(from o in Order.Item, select: o, where: o.item_id == ^item_id and o.order_id == ^user_id)
      |> KiraBijoux.Order.Item.changeset(%{quantity: quantity})
      case Repo.update order_item do
        {:ok, order_item} ->
          put_status(conn, 200)
          |> KiraBijouxWeb.OrderItemView.render("index.json", %{order_item: order_item})
        {:error, changeset} ->
          Logger.error changeset
          put_status(conn, 500)
      end
    end
  end

  # remove item to shopping cart
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/shop/{item_id}/{user_id}")
    summary("Delete Item of shopping cart")
    description("Delete a Item by id")
    parameter :item_id, :path, :integer, "The id of the item of shopping cart to be deleted", required: true
    parameters do
      user_id :path, :integer, "The id of the user of the shopping cart to be created", required: true
    end
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"item_id" => item_id, "user_id" => user_id}) do
    order_item = Repo.one(from o in Order.Item, select: o, where: o.item_id == ^item_id and o.order_id == ^user_id)
    if order_item == nil do
      Logger.error("l'item n'est pas présent dans le panier")
      put_status(conn, 404)
      |> json([])
    else
      Repo.delete(order_item)
      put_status(conn, 200)
      |> KiraBijouxWeb.OrderItemView.render("index.json", %{order_item: order_item})
    end
  end
end
