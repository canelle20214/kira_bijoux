defmodule KiraBijouxWeb.UserFavoriteController do
  use KiraBijouxWeb, :controller

  # get all user favorites
  swagger_path :index do
    get("/user-favorites")
    summary("Get all user_favorites")
    description("List of User.Favorites")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    user_favorites = Repo.all(from uf in User.Favorite, select: uf)
    put_status(conn, 200)
    |> UserFavoriteView.render("index.json", %{user_favorites: user_favorites})
  end

  def swagger_definitions do
    %{
      user_favorite: swagger_schema do
        title "User.Favorite"
        description "User.Favorite descr"
        properties do
          user_id :integer, "Order id"
          quantity :integer, "Quantity"
          item_id :integer, "Item id"
        end
      end
    }
  end

  # create user_favorite
  swagger_path :create do
    post("/user-favorites")
    summary("Create user_favorite")
    description("Create a new User.Favorite")
    parameter :user_favorite, :body, Schema.ref(:user_favorite), "User.Favorite", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
          user_id: 1,
          item_id: 2
        })
    produces "application/json"
    response(201, "Created", Schema.ref(:user_favorite),
      example:
        %{
          user_id: 1,
          item_id: 2
        }
    )
  end

  def create(conn, %{"user_id" => user_id, "item_id" => item_id}) do
    case Repo.insert %User.Favorite{user_id: user_id, item_id: item_id} do
      {:ok, user_favorite} ->
        put_status(conn, 201)
        |> UserFavoriteView.render("index.json", %{user_favorite: user_favorite})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get user favorite by id
  swagger_path :show do
    get("/user-favorites/{id}")
    summary("Get user_favorite by id")
    description("User.Favorite filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    user_favorite = Repo.get!(User.Favorite, id)
    put_status(conn, 200)
    |> UserFavoriteView.render("index.json", %{user_favorite: user_favorite})
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")


  # get user favorite by order
  swagger_path :showByOrderId do
    get("/user-favorites/order/{id}")
    summary("Get user_favorite by order id")
    description("User.Favorite filtered by user_id")
    parameter :id, :path, :integer, "Id of order's user favorites to be displayed", required: true
    response(code(:ok), "Success")
  end

  def showByOrderId(conn, %{"id" => id}) do
    case Repo.all(from uf in User.Favorite, select: uf,
      where: uf.user_id == ^id) do
      [] ->
        Logger.error "Aucun user_favorites trouver"
        put_status(conn, 404)
        |> json("Not found")
      user_favorites ->
        Logger.info "Recherche user_favorites en cours"
        put_status(conn, 200)
        |> UserFavoriteView.render("index.json", %{user_favorites: user_favorites})
    end
  end


  # update user favorite
  swagger_path :update do
    put("/user-favorites/{id}")
    summary("Update user_favorite")
    description("Update an existing User.Favorite")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the user favorite to be updated", required: true
    parameter :user_favorite, :body, Schema.ref(:user_favorite), "Changes in user favorite", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        user_id: 1,
        item_id: 2
      }
    )
    produces "application/json"
    response(200, "OK", Schema.ref(:user_favorite),
      example:
        %{
          user_id: 1,
          item_id: 2
        }
    )
  end

  def update(conn, %{"id" => id} = params) do
    user_favorite = Repo.get!(User.Favorite, id)
    user_id = params["user_id"] || user_favorite.user_id
    item_id = params["item_id"] || user_favorite.item_id
    case Repo.update User.Favorite.changeset(user_favorite, %{user_id: user_id, item_id: item_id}) do
      {:ok, user_favorite} ->
        put_status(conn, 200)
        |> UserFavoriteView.render("index.json", %{user_favorite: user_favorite})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end

  # delete user_favorite
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/user-favorites/{id}")
    summary("Delete user_favorite")
    description("Delete a User.Favorite by id")
    parameter :id, :path, :integer, "The id of the user favorite to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with user_favorite = %User.Favorite{} <- Repo.get(User.Favorite, id),
    {:ok, _} <- Repo.delete user_favorite  do
        #Phoenix.json/2 cannot render 204 status https://git.pleroma.social/pleroma/pleroma/-/issues/2029
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
      nil ->
        Logger.error "L'item favoris n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
