defmodule KiraBijouxWeb.ArticleController do
  use KiraBijouxWeb, :controller

  # get all articles
  swagger_path :index do
    get("/articles")
    summary("Get all articles")
    description("List of articles")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    articles = Repo.all(from a in Article, select: a)
    put_status(conn, 200)
    |> ArticleView.render("index.json", %{articles: articles})
  end

  def swagger_definitions do
    %{
      Article: swagger_schema do
        title "Article"
        description "Article is a text to display on a page (view)."
        properties do
          name :string, "Name"
          content :string, "Content"
          page_id :integer, "Page id"
          place :integer, "Place"
        end
      end
    }
  end

  # get article by id
  swagger_path :show do
    get("/articles/{id}")
    summary("Get article by id")
    description("Article filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.one(from a in Article, select: a, where: a.id == ^id) do
      nil ->
        Logger.error("l'article n'existe pas")
        put_status(conn, 404)
        |> json("Not found")
      article ->
        put_status(conn, 200)
        |> ArticleView.render("index.json", %{article: article})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # get article by page_id
  swagger_path :showByPageId do
    get("/articles/page/{id}")
    summary("Get article by page_id")
    description("Article filtered by page id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def showByPageId(conn, %{"id" => id}) do
    case Repo.all(from a in Article, select: a, where: a.page_id == ^id) do
      [] ->
        Logger.error("Aucun article n'est lié à cette page.")
        put_status(conn, 404)
        |> json("Not found")
      articles ->
        put_status(conn, 200)
        |> ArticleView.render("index.json", %{articles: articles})
    end
  end
  def showByPageId(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # create article
  swagger_path :create do
    post("/articles")
    summary("Create article")
    description("Create a new article")
    parameter :article, :body, Schema.ref(:Article), "Article", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
          name: "Qui sommes-nous ?",
          content: "KiraBijoux est né du projet de Cyrielle Gallou de créer ses propres bijoux autour de ses pierres semi-précieuses favorites.",
          page_id: 1,
          place: 1
        })
    produces "application/json"
    response(201, "Created", Schema.ref(:Article),
      example:
      %{
        article:
        %{
          name: "Qui sommes-nous ?",
          content: "KiraBijoux est né du projet de Cyrielle Gallou de créer ses propres bijoux autour de ses pierres semi-précieuses favorites.",
          page_id: 1,
          place: 1
        }
      }
    )
  end
  def create(conn, %{"page_id" => page_id, "name" => name, "content" => content, "place" => place}) do
    case Repo.insert(%Article{page_id: page_id, name: name, content: content, place: place}) do
      {:ok, article} ->
        put_status(conn, 201)
        |> ArticleView.render("index.json", %{article: article})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: conn |> put_status(400) |> json("Bad request")

  # update article
  swagger_path :update do
    put("/articles/{id}")
    summary("Update article")
    description("Update an existing article")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the article to be updated", required: true
    parameter :article, :body, Schema.ref(:Article), "Changes in article", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        name: "Qui sommes-nous ?",
        content: "KiraBijoux est né du projet de Cyrielle Gallou de créer ses propres bijoux autour de ses pierres semi-précieuses favorites.",
        page_id: 1,
        place: 1
      }
    )
    produces "application/json"
    response(200, "OK", Schema.ref(:Article),
      example:
        %{
          name: "Qui sommes-nous ?",
          content: "KiraBijoux est né du projet de Cyrielle Gallou de créer ses propres bijoux autour de ses pierres semi-précieuses favorites.",
          page_id: 1,
          place: 1
        }
    )
  end

  def update(conn, %{"id" => id} = params) do
    case Repo.get(Article, id) do
      nil ->
        Logger.error("l'article n'existe pas")
        put_status(conn, 404)
        |> json("Not found")
      article ->
        name = params["name"] || article.name
        content = params["content"] || article.content
        page_id = params["page_id"] || article.page_id
        place = params["place"] || article.place
        case Repo.update Article.changeset(article, %{name: name, content: content, page_id: page_id, place: place}) do
          {:ok, article} ->
            put_status(conn, 200)
            |> ArticleView.render("index.json", %{article: article})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete article
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/articles/{id}")
    summary("Delete Article")
    description("Delete a Article by id")
    parameter :id, :path, :integer, "The id of the article to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with article = %Article{} <- Repo.one(from a in Article, select: a, where: a.id == ^id),
    {:ok, _} <- Repo.delete article do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      nil ->
        Logger.error("l'article n'existe pas")
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
