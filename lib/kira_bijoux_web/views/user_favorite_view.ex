defmodule KiraBijouxWeb.UserFavoriteView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{user_favorite: user_favorite}) do
    conn
    |> json(user_favorite_construction(user_favorite))
  end

  def render(conn, "index.json", %{user_favorites: user_favorites}) do
    user_favorites = Enum.map(user_favorites, & user_favorite_construction(&1))
    conn
    |> json(user_favorites)
  end

  def user_favorite_construction(user_favorite) do
    user = Repo.get!(User, user_favorite.user_id)
    |> KiraBijouxWeb.UserView.user_construction()
    item = Repo.get!(Item, user_favorite.item_id)
    |> KiraBijouxWeb.ItemView.item_construction()
    Map.new(id: user_favorite.id)
    |> Map.put(:user, user)
    |> Map.put(:item, item)
    |> Map.put(:inserted_at, user_favorite.inserted_at)
    |> Map.put(:updated_at, user_favorite.updated_at)
  end
end
