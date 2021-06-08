defmodule KiraBijouxWeb.UserNewsletterController do
  use KiraBijouxWeb, :controller

  # get all user newsletters
  swagger_path :index do
    get("/user-newsletters")
    summary("Get all user_newsletters")
    description("List of User.Newsletters")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    user_newsletters = Repo.all(from un in User.Newsletter, select: un)
    put_status(conn, 200)
    |> UserNewsletterView.render("index.json", %{user_newsletters: user_newsletters})
  end

  def swagger_definitions do
    %{
      user_newsletter: swagger_schema do
        title "User.Newsletter"
        description "User.Newsletter descr"
        properties do
          newsletter_id :integer, "Newsletter id"
          user_id :integer, "User id"
          mail :string, "Mail"
          item_id :integer, "Item id"
        end
      end
    }
  end

  # create user_newsletter
  swagger_path :create do
    post("/user-newsletters")
    summary("Create user_newsletter")
    description("Create a new User.Newsletter")
    parameter :user_newsletter, :body, Schema.ref(:user_newsletter), "User.Newsletter", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
          newsletter_id: 1,
          user_id: 1,
          mail: "nomprénom@gmail.com",
          item_id: 1
        })
    produces "application/json"
    response(201, "Created", Schema.ref(:user_newsletter),
      example:
        %{
          newsletter_id: 1,
          user_id: 1,
          mail: "nomprénom@gmail.com",
          item_id: 1
        }
    )
  end

  def create(conn, %{"newsletter_id" => newsletter_id, "user_id" => user_id, "item_id" => item_id}) do
    with %User{} <- Repo.get(User, user_id),
    %Item{} <- Repo.get(Item, item_id),
    %Newsletter{} <- Repo.get(Newsletter, newsletter_id),
    {:ok, user_newsletter} <- Repo.insert %User.Newsletter{newsletter_id: newsletter_id, user_id: user_id, item_id: item_id} do
      put_status(conn, 201)
      |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
    else
      nil ->
        Logger.error "L'user, l'item ou la newsletter n'existe pas."
        put_status(conn, 400)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, %{"newsletter_id" => newsletter_id, "mail" => mail, "item_id" => item_id}) do
    with true <- Regex.match?(~r/^\w+([-._]?\w+)+@\w+(\w+?[._-])+.(\w){2,3}+$/, mail),
    %Item{} <- Repo.get(Item, item_id),
    %Newsletter{} <- Repo.get(Newsletter, newsletter_id),
    nil <- Repo.one(from u in User, where: u.mail == ^mail),
    {:ok, user_newsletter} <- Repo.insert %User.Newsletter{newsletter_id: newsletter_id, mail: mail, item_id: item_id} do
      put_status(conn, 201)
      |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
    else
      user = %User{} ->
        case Repo.insert %User.Newsletter{newsletter_id: newsletter_id, user_id: user.id, item_id: item_id} do
          {:ok, user_newsletter} ->
            put_status(conn, 201)
            |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
      false ->
        Logger.error "L'adresse mail n'est pas au bon format."
        put_status(conn, 400)
        |> json("Bad request")
      nil ->
        Logger.error "L'item ou la newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, %{"newsletter_id" => newsletter_id, "user_id" => user_id}) do
    with %User{} <- Repo.get(User, user_id),
    %Newsletter{} <- Repo.get(Newsletter, newsletter_id),
    {:ok, user_newsletter} <- Repo.insert %User.Newsletter{newsletter_id: newsletter_id, user_id: user_id} do
      put_status(conn, 201)
      |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
    else
      nil ->
        Logger.error "L'user ou la newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, %{"newsletter_id" => newsletter_id, "mail" => mail}) do
    with true <- Regex.match?(~r/^\w+([-._]?\w+)+@\w+(\w+?[._-])+.(\w){2,3}+$/, mail),
    %Newsletter{} <- Repo.get(Newsletter, newsletter_id),
    nil <- Repo.one(from u in User, where: u.mail == ^mail),
    {:ok, user_newsletter} <- Repo.insert %User.Newsletter{newsletter_id: newsletter_id, mail: mail} do
      put_status(conn, 201)
      |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
    else
      user = %User{} ->
        case Repo.insert %User.Newsletter{newsletter_id: newsletter_id, user_id: user.id} do
          {:ok, user_newsletter} ->
            put_status(conn, 201)
            |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
      nil ->
        Logger.error "La newsletter n'existe pas."
        put_status(conn, 400)
        |> json("Bad request")
      false ->
        Logger.error "L'adresse mail n'est pas au bon format."
        put_status(conn, 400)
        |> json("Bad request")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get user newsletter by id
  swagger_path :show do
    get("/user-newsletters/{id}")
    summary("Get user_newsletter by id")
    description("User.Newsletter filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(User.Newsletter, id) do
      nil ->
        Logger.error "L'user_newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      user_newsletter ->
        put_status(conn, 200)
        |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get user newsletters by item
  swagger_path :showByItemId do
    get("/user-newsletters/item/{id}")
    summary("Get user_newsletters by item id")
    description("User.Newsletter filtered by item_id")
    parameter :id, :path, :integer, "Id of item's user newsletters to be displayed", required: true
    response(code(:ok), "Success")
  end

  def showByItemId(conn, %{"id" => id}) do
    case Repo.all(from un in User.Newsletter, select: un,
      where: un.item_id == ^id) do
      [] ->
        Logger.error("aucun user_newsletters trouver")
        put_status(conn, 404)
        |> json("Not found")
      user_newsletters ->
        Logger.info("recherche user_newsletters en cours")
        put_status(conn, 200)
        |> UserNewsletterView.render("index.json", %{user_newsletters: user_newsletters})
    end
  end
  def showByItemId(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get user newsletters by user_id
  swagger_path :showByUserId do
    get("/user-newsletters/user/{id}")
    summary("Get user_newsletters by user id")
    description("User.Newsletter filtered by user_id")
    parameter :id, :path, :integer, "Id of user's user newsletters to be displayed", required: true
    response(code(:ok), "Success")
  end

  def showByUserId(conn, %{"id" => id}) do
    case Repo.all(from un in User.Newsletter, select: un,
      where: un.user_id == ^id) do
      [] ->
        Logger.error("aucun user_newsletters trouver")
        put_status(conn, 404)
        |> json("Not found")
      user_newsletters ->
        Logger.info("recherche user_newsletters en cours")
        put_status(conn, 200)
        |> UserNewsletterView.render("index.json", %{user_newsletters: user_newsletters})
    end
  end
  def showByUserId(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get user newsletters by mail
  swagger_path :showByMail do
    get("/user-newsletters/mail/{mail}")
    summary("Get user_newsletters by mail")
    description("User.Newsletter filtered by mail")
    parameter :id, :path, :integer, "Mail of user newsletters to be displayed", required: true
    response(code(:ok), "Success")
  end

  def showByMail(conn, %{"mail" => mail}) do
    case Repo.all(from un in User.Newsletter, select: un,
      where: un.mail == ^mail) do
      [] ->
        Logger.error("aucun user_newsletters trouver")
        put_status(conn, 404)
        |> json("Not found")
      user_newsletters ->
        Logger.info("recherche user_newsletters en cours")
        put_status(conn, 200)
        |> UserNewsletterView.render("index.json", %{user_newsletters: user_newsletters})
    end
  end
  def showByMail(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # update user newsletter
  swagger_path :update do
    put("/user-newsletters/{id}")
    summary("Update user_newsletter")
    description("Update an existing User.Newsletter")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the user newsletter to be updated", required: true
    parameter :user_newsletter, :body, Schema.ref(:user_newsletter), "Changes in user newsletter", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        newsletter_id: 1,
        user_id: 1,
        mail: "nomprénom@gmail.com",
        item_id: 1
      }
    )
    produces "application/json"
    response(200, "OK", Schema.ref(:user_newsletter),
      example:
        %{
          newsletter_id: 1,
          user_id: 1,
          mail: "nomprénom@gmail.com",
          item_id: 1
        }
    )
  end

  def update(conn, %{"id" => id, "user_id" => user_id} = params) do
    case Repo.get(User.Newsletter, id) do
      nil ->
        Logger.error "L'user_newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      user_newsletter ->
        newsletter_id = params["newsletter_id"] || user_newsletter.newsletter_id
        item_id = params["item_id"] || user_newsletter.item_id
        with %Newsletter{} <- Repo.get(Newsletter, newsletter_id),
        {:user, %User{}} <- {:user, Repo.get(User, user_id)},
        {:ok, user_newsletter} <- Repo.update User.Newsletter.changeset(user_newsletter, %{newsletter_id: newsletter_id, user_id: user_id, mail: nil, item_id: item_id}) do
            put_status(conn, 200)
            |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
        else
          {:user, nil} ->
            Logger.error "Le user n'existe pas."
            put_status(conn, 400)
            |> json("Bad request")
          nil ->
            Logger.error "La newsletter n'existe pas."
            put_status(conn, 400)
            |> json("Bad request")
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, %{"id" => id, "mail" => mail} = params) do
    case Repo.get(User.Newsletter, id) do
      nil ->
        Logger.error "L'user_newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      user_newsletter ->
        newsletter_id = params["newsletter_id"] || user_newsletter.newsletter_id
        item_id = params["item_id"] || user_newsletter.item_id
        with %Newsletter{} <- Repo.get(Newsletter, newsletter_id),
        nil <- Repo.one(from u in User, where: u.mail == ^mail),
        true <- Regex.match?(~r/^\w+([-._]?\w+)+@\w+(\w+?[._-])+.(\w){2,3}+$/, mail),
        {:ok, user_newsletter} <- Repo.update User.Newsletter.changeset(user_newsletter, %{newsletter_id: newsletter_id, mail: mail, user_id: nil, item_id: item_id}) do
            put_status(conn, 200)
            |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
        else
          nil ->
            Logger.error "La newsletter n'existe pas."
            put_status(conn, 400)
            |> json("Bad request")
          user = %User{} ->
            case Repo.update User.Newsletter.changeset(user_newsletter, %{newsletter_id: newsletter_id, mail: nil, user_id: user.id, item_id: item_id}) do
              {:ok, user_newsletter} ->
                put_status(conn, 200)
                |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
              {:error, changeset} ->
                Logger.error "ERROR : #{inspect changeset}"
                put_status(conn, 500)
            end
          false ->
            Logger.error "L'adresse mail n'est pas au bon format."
            put_status(conn, 400)
            |> json("Bad request")
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, %{"id" => id} = params) do
    case Repo.get(User.Newsletter, id) do
      nil ->
        Logger.error "L'user_newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      user_newsletter ->
        newsletter_id = params["newsletter_id"] || user_newsletter.newsletter_id
        item_id = params["item_id"] || user_newsletter.item_id
        with %Newsletter{} <- Repo.get(Newsletter, newsletter_id),
        {:ok, user_newsletter} <- Repo.update User.Newsletter.changeset(user_newsletter, %{newsletter_id: newsletter_id, item_id: item_id}) do
            put_status(conn, 200)
            |> UserNewsletterView.render("index.json", %{user_newsletter: user_newsletter})
        else
          nil ->
            Logger.error "La newsletter n'existe pas."
            put_status(conn, 400)
            |> json("Bad request")
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete user_newsletter
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/user-newsletters/{id}")
    summary("Delete user_newsletter")
    description("Delete a User.Newsletter by id")
    parameter :id, :path, :integer, "The id of the user newsletter to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with user_newsletter = %User.Newsletter{} <- Repo.get(User.Newsletter, id),
    {:ok, _} <- Repo.delete user_newsletter do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      nil ->
        Logger.error "L'user newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
