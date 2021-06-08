defmodule KiraBijouxWeb.CollectionController do
  use KiraBijouxWeb, :controller

  # get all collections
  swagger_path :index do
    get("/collections")
    summary("Get all collections")
    description("List of collections")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    collections = Repo.all(from c in Collection, select: c)
    put_status(conn, 200)
    |> CollectionView.render("index.json", %{collections: collections})
  end

  def swagger_definitions do
    %{
      Collection: swagger_schema do
        title "Collection"
        description "Collection descr"
        properties do
          name :string, "Name"
        end
      end
    }
  end

  # get collection by id
  swagger_path :show do
    get("/collections/{id}")
    summary("Get collections by id")
    description("Collections filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.one(from c in Collection, select: c, where: c.id == ^id) do
      nil ->
        Logger.error("la collection n'existe pas")
        put_status(conn, 404)
        |> json("Not found")
      collection ->
        put_status(conn, 200)
        |> CollectionView.render("index.json", %{collection: collection})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # create collection
  swagger_path :create do
    post("/collections")
    summary("Create Collections")
    description("Create a new Collections")
    produces "application/json"
    parameter :collection, :body, Schema.ref(:Collection), "Collection", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Collection 2022"
    })
    produces "application/json"
    response(201, "Created", Schema.ref(:Collection),
      example:
        %{
          name: "Collection 2022"
        }
    )
  end

  def create(conn, %{"name" => name}) do
    case Repo.insert %Collection{name: name} do
      {:ok, collection} ->
        put_status(conn, 201)
        |> CollectionView.render("index.json", %{collection: collection})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # update collection
  swagger_path :update do
    put("/collections/{id}")
    summary("Update collection")
    description("Update an existing Collection")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the collection to be updated", required: true
    parameter :collection, :body, Schema.ref(:Collection), "Changes in collection", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Collection 2023"
      }
    )
    produces "application/json"
    response(200, "OK", Schema.ref(:Collection),
      example:
        %{
          name: "Collection 2022"
        }
    )
  end

  def update(conn, %{"id" => id, "name" => name}) do
    with collection = %Collection{} <- Repo.get(Collection, id),
    {:ok, collection} <- Repo.update Collection.changeset(collection, %{name: name}) do
      put_status(conn, 200)
      |> CollectionView.render("index.json", %{collection: collection})
    else
      nil ->
        Logger.error "La collection n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete collection
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/collections/{id}")
    summary("Delete collection")
    description("Delete a Collection by id")
    parameter :id, :path, :integer, "The id of the collection to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with collection = %Collection{} <- Repo.get(Collection, id),
    {:ok, _} <- Repo.delete collection  do
        put_status(conn, 200)
        |> json([])
    else
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
      nil ->
        Logger.error "La collection n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
