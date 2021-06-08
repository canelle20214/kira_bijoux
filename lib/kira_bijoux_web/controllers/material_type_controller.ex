defmodule KiraBijouxWeb.MaterialTypeController do
  use KiraBijouxWeb, :controller

  # get all material types
  swagger_path :index do
    get("/material-types")
    summary("Get all material types")
    description("List of material types")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    material_types = Repo.all(from mt in Material.Type, select: mt)
    put_status(conn, 200)
    |> MaterialTypeView.render("index.json", %{material_types: material_types})
  end

  def swagger_definitions do
    %{
      Material_Type: swagger_schema do
        title "Material.Type"
        description "Material.Type descr"
        properties do
          name :string, "Name"
        end
      end
    }
  end

  # get material type by id
  swagger_path :show do
    get("/material-types/{id}")
    summary("Get material types by id")
    description("Material.Types filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    case Repo.one(from mt in Material.Type, select: mt, where: mt.id == ^id) do
      nil ->
        Logger.error("l'material type n'existe pas")
        put_status(conn, 404)
        |> json("Not found")
      material_type ->
        put_status(conn, 200)
        |> MaterialTypeView.render("index.json", %{material_type: material_type})
    end
  end
  def show(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # create material type
  swagger_path :create do
    post("/material-types")
    summary("Create Material Types")
    description("Create a new Material.Type")
    produces "application/json"
    parameter :material_type, :body, Schema.ref(:Material_Type), "Material_Type", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      name: "Pierre semi-précieuse"
    })
    produces "application/json"
    response(201, "Created", Schema.ref(:Material_Type),
      example:
        %{
          name: "Pierre semi-précieuse"
        }
    )
  end

  def create(conn, %{"name" => name}) do
    case Repo.insert %Material.Type{name: name} do
      {:ok, material_type} ->
        put_status(conn, 201)
        |> MaterialTypeView.render("index.json", %{material_type: material_type})
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # update material type
  swagger_path :update do
    put("/material-types/{id}")
    summary("Update material type")
    description("Update an existing Material.Type")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the material type to be updated", required: true
    parameter :material_type, :body, Schema.ref(:Material_Type), "Changes in material type", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        name: "Pierre semi-précieuse"
      }
    )
    produces "application/json"
    response(200, "OK", Schema.ref(:Material_Type),
      example:
        %{
          name: "Pierre semi-précieuse"
        }
    )
  end

  def update(conn, %{"id" => id, "name" => name}) do
    with material_type = %Material.Type{} <- Repo.get(Material.Type, id),
    {:ok, material_type} <- Repo.update Material.Type.changeset(material_type, %{name: name}) do
      put_status(conn, 200)
      |> MaterialTypeView.render("index.json", %{material_type: material_type})
    else
      nil ->
        Logger.error "Le type de matériaux n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
    end
  end
  def update(conn, _), do: put_status(conn, 400) |> json("Bad request")

  # delete material type
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/material-types/{id}")
    summary("Delete material types")
    description("Delete a Material.Types by id")
    parameter :id, :path, :integer, "The id of the material types to be deleted", required: true
    response(200, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with material_type = %Material.Type{} <- Repo.get(Material.Type, id),
    {:ok, _} <- Repo.delete material_type  do
      put_status(conn, 200)
      |> json("No Content - Deleted Successfully")
    else
      {:error, changeset} ->
        Logger.error "ERROR : #{inspect changeset}"
        put_status(conn, 500)
      nil ->
        Logger.error "Le type de matériaux n'existe pas."
        put_status(conn, 404)
        |> json("Not found")
    end
  end
  def delete(conn, _), do: put_status(conn, 400) |> json("Bad request")
end
