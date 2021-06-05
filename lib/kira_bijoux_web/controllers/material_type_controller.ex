defmodule KiraBijouxWeb.MaterialTypeController do
  use KiraBijouxWeb, :controller

  # get all material types
  swagger_path :index do
    get("/material-types")
    summary("Get all material_types")
    description("List of Material.Type")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    material_types = Repo.all(from mt in Material.Type, select: mt)
    put_status(conn, 200)
    |> MaterialTypeView.render("index.json", %{material_types: material_types})
  end

  def swagger_definitions do
    %{
      material_type: swagger_schema do
        title "Material.Type"
        description "Material.Type descr"
        properties do
          name :string, "Name"
        end
      end
    }
  end

  # create material_type
  swagger_path :create do
    post("/material-types")
    summary("Create material_type")
    description("Create a new Material.Type")
    parameter :material_type, :body, Schema.ref(:material_type), "Material.Type", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
          name: "Pierre semi-précieuse"
        })
    produces "application/json"
    response(200, "OK", Schema.ref(:material_type),
      example:
      %{
        material_type:
        %{
          name: "Pierre semi-précieuse",
        }
      }
    )
  end

  def create(conn, %{"name" => name}) do
    case Repo.insert %Material.Type{name: name} do
      {:ok, material_type} ->
        put_status(conn, 201)
        |> MaterialTypeView.render("index.json", %{material_type: material_type})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400)

  # get material type by id
  swagger_path :show do
    get("/material-types/{id}")
    summary("Get material_type by id")
    description("Material.Type filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    material_type = Repo.get!(Material.Type, id)
    put_status(conn, 200)
    |> MaterialTypeView.render("index.json", %{material_type: material_type})
  end


  # update material type
  swagger_path :update do
    put("/material-types/{id}")
    summary("Update material_type")
    description("Update an existing Material.Type")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the material type to be updated", required: true
    parameter :material_type, :body, Schema.ref(:material_type), "Changes in material type", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        name: "Pierre semi-précieuse"
      }
    )
  end

  def update(conn, %{"id" => id, "name" => name}) do
    material_type = Repo.get!(Material.Type, id)
    case Repo.update Material.Type.changeset(material_type, %{name: name}) do
      {:ok, material_type} ->
        put_status(conn, 200)
        |> MaterialTypeView.render("index.json", %{material_type: material_type})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
  def update(conn, _), do: put_status(conn, 400)

  # delete material_type
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/material-types/{id}")
    summary("Delete material_type")
    description("Delete a Material.Type by id")
    parameter :id, :path, :integer, "The id of the material type to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete Repo.get!(Material.Type, id) do
      {:ok, material_type} ->
        #Phoenix.json/2 cannot render 204 status https://git.pleroma.social/pleroma/pleroma/-/issues/2029
        put_status(conn, 200)
        |> MaterialTypeView.render("index.json", %{material_type: material_type})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
