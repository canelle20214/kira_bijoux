defmodule KiraBijouxWeb.UserController do
  use KiraBijouxWeb, :controller

  def index(conn, _params) do
    users = Repo.all(from u in User, select: u)
    put_status(conn, 200)
    |> KiraBijouxWeb.UserView.render("index.json", %{users: users})
  end

  def create(conn, params) do
    firstname = params["firstname"]
    lastname = params["lastname"]
    mail = params["mail"]
    password = params["password"]
    case Repo.insert %User{firstname: firstname, lastname: lastname, mail: mail, password: password, user_role_id: 1} do
      {:ok, user} ->
        put_status(conn, 201)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  def show(conn, %{"user_id" => id}) do
    user = Repo.get!(User, id)
    put_status(conn, 200)
    |> KiraBijouxWeb.UserView.render("show.json", %{user: user})
  end

  def update(conn, %{"user_id" => id, "mail" => mail}) do
    user = Repo.get!(User, id)
    |> KiraBijoux.User.changeset(%{mail: mail})
    case Repo.update user do
      {:ok, user} ->
        put_status(conn, 200)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  def delete(conn, %{"user_id" => id}) do
    user = Repo.get!(User, id)
    case Repo.delete user do
      {:ok, user} ->
        put_status(conn, 200)
        |> KiraBijouxWeb.UserView.render("index.json", %{user: user})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
