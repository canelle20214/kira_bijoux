defmodule KiraBijouxWeb.ShoppingCartController do
  use KiraBijouxWeb, :controller

  # get all shopping cart
  swagger_path :index do
    get("/shops")
    summary("Get all shopping cart")
    description("List of shopping cart")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    order_items = Repo.all(from oi in Order.Item, select: oi)
    put_status(conn, 200)
    |> OrderItemView.render("index.json", %{order_items: order_items})
  end

  # get shopping cart by id
  swagger_path :show do
    get("/shops/{id}")
    summary("Get shopping cart by id")
    description("shopping cart filtered by id")
    parameter :id, :path, :integer, "The id of the shopping cart to be created", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    with order = %Order{} <- Repo.get(Order, id),
    order_items when order_items != [] <- Repo.all(from i in Order.Item, select: i, where: i.order_id == ^order.id) do
      Logger.info "Recherche panier en cours."
      put_status(conn, 200)
      |> OrderItemView.render("index.json", %{order_items: order_items})
    else
      nil ->
        Logger.error "Aucun panier ne porte cet id."
        put_status(conn, 404)
        |> json("Not found")
      [] ->
        Logger.error "Le panier est vide."
        put_status(conn, 200)
        |> json([])
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get shopping cart by user
  swagger_path :showByUserAddressId do
    get("/shops/user-address/{id}")
    summary("Get shopping cart by user address id")
    description("shopping cart filtered by user address id")
    parameter :id, :path, :integer, "The user_id of the shopping cart to be created", required: true
    response(code(:ok), "Success")
  end

  def showByUserAddressId(conn, %{"id" => id}) do
    order = Repo.all(from o in Order,
    select: o,
    where: o.user_address_id == ^id,
    order_by: [desc: o.id])
    |> List.first
    with order = %Order{} <- order,
    order_items when order_items != [] <- Repo.all(from i in Order.Item, select: i, where: i.order_id == ^order.id) do
      Logger.info "Recherche panier en cours."
      put_status(conn, 200)
      |> OrderItemView.render("index.json", %{order_items: order_items})
    else
      nil ->
        Logger.error "Aucun panier n'est lié à cette adresse."
        put_status(conn, 404)
        |> json("Not found")
      [] ->
        Logger.error "Le panier est vide."
        put_status(conn, 200)
        |> json([])
    end
  end
  def showByUserAddressId(conn, _), do: put_status(conn, 400) |> json("Bad request")

  def swagger_definitions do
    %{
      Shop: swagger_schema do
        title "Shop"
        description "Shop descr"
        properties do
          item_id :integer, "Item id"
          user_address_id :integer, "User Address id"
          quantity :integer, "Quantity"
        end
      end
    }
  end

  # add product to shopping cart
  swagger_path :create do
    post("/shops")
    summary("Create shopping cart")
    description("Create a new shopping cart")
    produces "application/json"
    parameter :shop, :body, Schema.ref(:Shop), "Shop", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      item_id: 1,
      user_address_id: 1,
      quantity: 1
    })
    produces "application/json"
    response(201, "Created", Schema.ref(:Shop),
      example:
        %{
          item_id: 1,
          user_address_id: 1,
          quantity: 2
        }
    )
  end

  def create(conn, %{"item_id" => item_id, "user_address_id" => user_address_id, "quantity" => quantity}) do
    with order = %Order{} <- Repo.all(from o in Order, select: o,
    where: o.user_address_id == ^user_address_id,
    order_by: [desc: o.id]) |> List.first, #dernier order inséré à l'adresse donnée
    order_items when order_items != [] <- Repo.all(from i in Order.Item, select: i, where: i.order_id == ^order.id), #liste des order_items correspondant à l'order non vide
    {:order_item, order_item = %Order.Item{}} <- {:order_item, Enum.find(order_items, &(&1.item_id == item_id))}, #order_item dans l'order ayant le même id que celui que l'on souhaite ajouté
    {:stock, stock} when is_integer(stock) <- {:stock, Repo.one(from i in Item, select: i.stock, where: i.id == ^item_id)}, #stock est un integer
    false <- (quantity + order_item.quantity) > stock do #quantity valide en fonction du stock
      case Repo.update Order.Item.changeset(order_item, %{quantity: quantity}) do
        {:ok, order_item} ->
          put_status(conn, 201)
          |> OrderItemView.render("index.json", %{order_item: order_item})
        {:error, changeset} ->
          Logger.error "ERROR : #{inspect changeset}"
          put_status(conn, 500)
      end
    else
      [] -> #l'order ne possède pas encore d'order_items
        order_id = Repo.all(from o in Order, select: o.id,
        where: o.user_address_id == ^user_address_id,
        order_by: [desc: o.id]) |> List.first
        with item_stock when is_integer(item_stock) <- Repo.one(from i in Item, select: i.stock, where: i.id == ^item_id), #stock est un integer
        false <- quantity > item_stock, #quantity valide en fonction du stock
        {:ok, order_item} <- Repo.insert %Order.Item{order_id: order_id, item_id: item_id, quantity: quantity} do #insertion de l'order_item
          put_status(conn, 201)
          |> OrderItemView.render("index.json", %{order_item: order_item})
        else
          nil -> #le stock n'est pas un integer
            Logger.error "L'item n'existe pas."
            put_status(conn, 404)
            |> json("Not found")
          true -> #quantity non valide
            Logger.error("la quantite saisi est incorrecte")
            put_status(conn, 400)
            |> json("Bad request")
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
          end
      {:stock , _} -> #le stock n'est pas un integer
        Logger.error "L'item n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      nil -> #aucun order ne correspond à cette adresse
        Logger.error "Le panier n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      true -> #quantity non valide
        Logger.error("la quantite saisi est incorrecte")
        put_status(conn, 400)
        |> json("Bad request")
      {:order_item, nil} -> #order_item non présent dans le panier
        item_stock = Repo.one(from i in Item, select: i.stock, where: i.id == ^item_id)
        if quantity > item_stock do
          Logger.error("la quantité saisi est incorrecte")
          put_status(conn, 400)
          |> json("Bad request")
        else
          order_id = Repo.all(from o in Order, select: o.id,
          where: o.user_address_id == ^user_address_id,
          order_by: [desc: o.id]) |> List.first
          case Repo.insert %Order.Item{order_id: order_id, item_id: item_id, quantity: quantity} do
          {:ok, order_item} ->
            put_status(conn, 201)
            |> OrderItemView.render("index.json", %{order_item: order_item})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
          end
        end
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # update quantity of item of shopping cart
  swagger_path :update do
    put("/shops/{item_id}/{order_id}")
    summary("Update quantity of shopping cart")
    description("Update an existing shopping cart")
    produces "application/json"
    parameters do
      item_id :path, :integer, "The id of the item of the shopping cart to be updated", required: true
      order_id :path, :integer, "The id of the order of the shopping cart to be updated", required: true
      quantity :query, :integer, "The quantity of the shopping cart to be updated", required: true
    end
    produces "application/json"
    response(200, "OK", Schema.ref(:Shop),
      example:
        %{
          item_id: 1,
          user_address_id: 1,
          quantity: 2
        }
    )
  end

  def update(conn, %{"item_id" => item_id, "order_id" => order_id, "quantity" => quantity}) do
    with false <- quantity > Repo.one(from i in Item, select: i.stock, where: i.id == ^item_id),
    order_item = %Order.Item{} <- Repo.one(from o in Order.Item, select: o, where: o.item_id == ^item_id and o.order_id == ^order_id),
    {:ok, order_item} <- Repo.update Order.Item.changeset(order_item, %{quantity: quantity}) do
      put_status(conn, 200)
      |> OrderItemView.render("index.json", %{order_item: order_item})
    else
      true ->
        Logger.error "La quantité est incorrecte."
        put_status(conn, 400)
        |> json([])
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
          put_status(conn, 500)
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # remove item to shopping cart
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/shops/{item_id}/{order_id}")
    summary("Delete Item of shopping cart")
    description("Delete a Item by id")
    parameters do
      item_id :path, :integer, "The id of the item of the shopping cart to be deleted", required: true
      order_id :path, :integer, "The id of the order of the shopping cart to be deleted", required: true
    end
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"item_id" => item_id, "order_id" => order_id}) do
    with order_item = %Order.Item{} <- Repo.one(from o in Order.Item, select: o, where: o.item_id == ^item_id and o.order_id == ^order_id),
    {:ok, _} <- Repo.delete order_item do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      nil ->
        Logger.error "L'item n'est pas présent dans le panier"
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
