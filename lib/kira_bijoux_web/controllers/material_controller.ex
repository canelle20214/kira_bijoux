defmodule KiraBijouxWeb.MaterialController do
  use KiraBijouxWeb, :controller

  # get all materials
  swagger_path :index do
    get("/materials")
    summary("Get all materials")
    description("List of Material")
    response(code(:ok), "Success")
  end

  def index(conn, _) do
    materials = Repo.all(from m in Material, select: m)
    put_status(conn, 200)
    |> MaterialView.render("index.json", %{materials: materials})
  end

  def swagger_definitions do
    %{
      material: swagger_schema do
        title "Material"
        description "Material descr"
        properties do
          name :string, "Name"
          material_type_id :integer, "Material type id"
        end
      end
    }
  end

  # create material
  swagger_path :create do
    post("/materials")
    summary("Create material")
    description("Create a new Material")
    parameter :material, :body, Schema.ref(:material), "Material", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
          name: "Perle",
          material_type_id: 1
        })
    produces "application/json"
    response(200, "OK", Schema.ref(:material),
      example:
      %{
        material:
        %{
          name: "Perle",
          material_type_id: 1
        }
      }
    )
  end

  def create(conn, %{"material_type_id" => material_type_id, "name" => name}) do
    case Repo.insert %Material{material_type_id: material_type_id, name: name} do
      {:ok, material} ->
        put_status(conn, 201)
        |> MaterialView.render("index.json", %{material: material})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
  def create(conn, _), do: put_status(conn, 400)

  # get material by id
  swagger_path :show do
    get("/materials/{id}")
    summary("Get material by id")
    description("Material filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    material = Repo.get!(Material, id)
    put_status(conn, 200)
    |> MaterialView.render("index.json", %{material: material})
  end


  # update material
  swagger_path :update do
    put("/materials/{id}")
    summary("Update material")
    description("Update an existing Material")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the material to be updated", required: true
    parameter :material, :body, Schema.ref(:material), "Changes in material", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        name: "Perle",
        material_type_id: 1
      }
    )
  end

  def update(conn, %{"id" => id} = params) do
    material = Repo.get!(Material, id)
    name = params["name"] || material.name
    material_type_id = params["material_type_id"] || material.material_type_id
    case Repo.update Material.changeset(material, %{name: name, material_type_id: material_type_id}) do
      {:ok, material} ->
        put_status(conn, 200)
        |> MaterialView.render("index.json", %{material: material})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
  def update(conn, _), do: put_status(conn, 400)

  # delete material
  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/materials/{id}")
    summary("Delete material")
    description("Delete a Material by id")
    parameter :id, :path, :integer, "The id of the material to be deleted", required: true
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete Repo.get!(Material, id) do
      {:ok, material} ->
        #Phoenix.json/2 cannot render 204 status https://git.pleroma.social/pleroma/pleroma/-/issues/2029
        put_status(conn, 200)
        |> MaterialView.render("index.json", %{material: material})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
