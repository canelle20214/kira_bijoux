defmodule KiraBijouxWeb.CollectionController do
  use KiraBijouxWeb, :controller

  # get all collections
  swagger_path :index do
    get("/collections")
    summary("Get all collections")
    description("List of collections")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
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
          name :integer, "Name"
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
    collection = Repo.one(from c in Collection, select: c, where: c.id == ^id)
    if collection == nil do
      Logger.error("la collection n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      put_status(conn, 200)
      |> CollectionView.render("index.json", %{collection: collection})
    end
  end

  # create collection
  swagger_path :create do
    post("/collections")
    summary("Create Collections")
    description("Create a new Collections")
    produces "application/json"
    parameter :collection, :body, Schema.ref(:Collection), "Collection", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Collection 2022"
    })
  end

  def create(conn, params) do
    name = params["name"]
    case Repo.insert %Collection{name: name} do
      {:ok, collection} ->
        put_status(conn, 201)
        |> CollectionView.render("index.json", %{collection: collection})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

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
  end

  def update(conn, params) do
    collection = Repo.get!(Collection, params["id"])
    name = params["name"] || collection.name
    case Repo.update Collection.changeset(collection, %{name: name}) do
      {:ok, collection} ->
        put_status(conn, 200)
        |> CollectionView.render("index.json", %{collection: collection})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # delete collection
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/collections/{id}")
    summary("Delete collection")
    description("Delete a Collection by id")
    parameter :id, :path, :integer, "The id of the collection to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete Repo.get!(Collection, id) do
      {:ok, collection} ->
        put_status(conn, 200)
        |> CollectionView.render("index.json", %{collection: collection})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
