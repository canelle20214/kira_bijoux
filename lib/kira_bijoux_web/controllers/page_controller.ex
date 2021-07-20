defmodule KiraBijouxWeb.PageController do
  use KiraBijouxWeb, :controller

  # get all pages
  swagger_path :index do
    get("/pages")
    summary("Get all pages")
    description("List of pages")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    pages = Repo.all(from p in Page, select: p)
    put_status(conn, 200)
    |> PageView.render("index.json", %{pages: pages})
  end

  def swagger_definitions do
    %{
      page: swagger_schema do
        title "Page"
        description "Page descr"
        properties do
          name :string, "Name"
          visibility :boolean, "Visibility"
        end
      end
    }
  end

  # get page by id
  swagger_path :show do
    get("/pages/{id}")
    summary("Get pages by id")
    description("Pages filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.one(from p in Page, select: p, where: p.id == ^id) do
      nil ->
        Logger.error "La page n'existe pas"
        put_status(conn, 404)
        |> json("Not found")
      page ->
        put_status(conn, 200)
        |> PageView.render("index.json", %{page: page})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # create page
  swagger_path :create do
    post("/pages")
    summary("Create Item Types")
    description("Create a new Pages")
    parameter :name, :query, :string, "Page name", required: true
    parameter :visibility, :query, :boolean, "Page will be visible or not", required: true
    produces "application/json"
    response(201, "Created", Schema.ref(:page),
      example:
        %{
          name: "Boutique",
          visibility: true
        }
    )
  end

  def create(conn, %{"name" => name, "visibility" => visibility}) do
    case Repo.insert %Page{name: name, visibility: visibility} do
      {:ok, page} ->
        put_status(conn, 201)
        |> PageView.render("index.json", %{page: page})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # update page
  swagger_path :update do
    put("/pages/{id}")
    summary("Update page")
    description("Update an existing Page")
    parameter :id, :path, :integer, "Id of the page to be updated", required: true
    parameter :name, :query, :string, "Page name", required: true
    parameter :visibility, :query, :boolean, "Page will be visible or not", required: true
    produces "application/json"
    response(200, "OK", Schema.ref(:page),
      example:
        %{
          name: "Boutique",
          visibility: true
        }
    )
  end

  def update(conn, %{"id" => id} = params) do
    case Repo.get(Page, id) do
      nil ->
        Logger.error "La page n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      page ->
        name = params["name"] || page.name
        visibility = params["visibility"] || page.visibility
        case Repo.update Page.changeset(page, %{name: name, visibility: visibility}) do
          {:ok, page} ->
            put_status(conn, 200)
            |> PageView.render("index.json", %{page: page})
          {:error, changeset} ->
            Logger.error "ERROR : #{inspect changeset}"
            put_status(conn, 500)
        end
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete page
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/pages/{id}")
    summary("Delete pages")
    description("Delete a Pages by id")
    parameter :id, :path, :integer, "The id of the pages to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with page = %Page{} <- Repo.get(Page, id),
    {:ok, _} <- Repo.delete page  do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
      nil ->
        Logger.error "La page n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
