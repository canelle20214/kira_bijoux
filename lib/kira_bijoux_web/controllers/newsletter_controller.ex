defmodule KiraBijouxWeb.NewsletterController do
  use KiraBijouxWeb, :controller

  # get all newsletters
  swagger_path :index do
    get("/newsletters")
    summary("Get all newsletters")
    description("List of newsletters")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    newsletters = Repo.all(from n in Newsletter, select: n)
    put_status(conn, 200)
    |> NewsletterView.render("index.json", %{newsletters: newsletters})
  end

  def swagger_definitions do
    %{
      Newsletter: swagger_schema do
        title "Newsletter"
        description "Newsletter descr"
        properties do
          name :string, "Name"
          object :string, "Object"
          content :string, "Content"
        end
      end
    }
  end

  # get newsletter by id
  swagger_path :show do
    get("/newsletters/{id}")
    summary("Get newsletter by id")
    description("Newsletter filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.one(from n in Newsletter, select: n, where: n.id == ^id) do
      nil ->
        Logger.error "La newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      newsletter ->
        put_status(conn, 200)
        |> NewsletterView.render("index.json", %{newsletter: newsletter})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # create newsletter
  swagger_path :create do
    post("/newsletters")
    summary("Create Newsletter")
    description("Create a new Newsletter")
    produces "application/json"
    parameter :newsletter, :body, Schema.ref(:Newsletter), "Newsletter", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Promo",
      object: "Promo Kira Bijoux",
      content: "Bénéficiez de {promo} de promo sur vos achats en ligne dès maintenant !"
    })
    produces "application/json"
    response(201, "Created", Schema.ref(:Newsletter),
      example:
        %{
          name: "Promo",
          object: "Promo Kira Bijoux",
          content: "Bénéficiez de {promo} de promo sur vos achats en ligne dès maintenant !"
        }
    )
  end

  def create(conn, %{"name" => name, "object" => object, "content" => content}) do
    case Repo.insert %Newsletter{name: name, object: object, content: content} do
      {:ok, newsletter} ->
        put_status(conn, 201)
        |> NewsletterView.render("index.json", %{newsletter: newsletter})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # update newsletter
  swagger_path :update do
    put("/newsletters/{id}")
    summary("Update newsletter")
    description("Update an existing Newsletter")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the newsletter to be updated", required: true
    parameter :newsletter, :body, Schema.ref(:Newsletter), "Changes in newsletter", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Promo",
      object: "Promo Kira Bijoux",
      content: "Bénéficiez de {promo} de promo sur vos achats en ligne dès maintenant !"
    })
    produces "application/json"
    response(200, "OK", Schema.ref(:Newsletter),
      example:
        %{
          name: "Promo",
          object: "Promo Kira Bijoux",
          content: "Bénéficiez de {promo} de promo sur vos achats en ligne dès maintenant !"
        }
    )
  end

  def update(conn, %{"id" => id} = params) do
    case Repo.get(Newsletter, id) do
      nil ->
        Logger.error "La newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      newsletter ->
        name = params["name"] || newsletter.name
        object = params["object"] || newsletter.object
        content = params["content"] || newsletter.content
        case Repo.update Newsletter.changeset(newsletter, %{name: name, object: object, content: content}) do
          {:ok, newsletter} ->
            put_status(conn, 200)
            |> NewsletterView.render("index.json", %{newsletter: newsletter})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete newsletter
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/newsletters/{id}")
    summary("Delete newsletter")
    description("Delete a Newsletter by id")
    parameter :id, :path, :integer, "The id of the newsletter to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with newsletter = %Newsletter{} <- Repo.get(Newsletter, id),
    {:ok, _} <- Repo.delete newsletter  do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
      nil ->
        Logger.error "La newsletter n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
