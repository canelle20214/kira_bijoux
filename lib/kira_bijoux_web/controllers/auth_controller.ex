defmodule KiraBijouxWeb.AuthController do
  import Plug.Conn.Status, only: [code: 1]
  use KiraBijouxWeb, :controller
  use PhoenixSwagger

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Signed up successfully.")
        |> redirect(to: movie_path(conn, :index))
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
    end
  end

  def connect(conn, %{"session" => auth_params}) do
    user = Accounts.get_by_username(auth_params["username"])
    case Comeonin.Bcrypt.check_pass(user, auth_params["password"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Signed in successfully.")
        |> redirect(to: movie_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "There was a problem with your username/password")
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: movie_path(conn, :index))
  end
end
