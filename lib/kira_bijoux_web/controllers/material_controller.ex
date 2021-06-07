defmodule KiraBijouxWeb.MaterialController do
  use KiraBijouxWeb, :controller

  # get all materials
  swagger_path :index do
    get("/materials")
    summary("Get all materials")
    description("List of materials")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
    materials = Repo.all(from m in Material, select: m)
    put_status(conn, 200)
    |> MaterialView.render("index.json", %{materials: materials})
  end

  def swagger_definitions do
    %{
      Material: swagger_schema do
        title "Material"
        description "Material descr"
        properties do
          material_type_id :integer, "Type id"
          name :integer, "Name"
        end
      end
    }
  end

  # get material by id
  swagger_path :show do
    get("/materials/{id}")
    summary("Get material by id")
    description("Material filtered by id")
    parameter :id, :path, :integer, "Id", required: true
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    material = Repo.one(from m in Material, select: m, where: m.id == ^id)
    if material == nil do
      Logger.error("le matériau n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      put_status(conn, 200)
      |> MaterialView.render("index.json", %{material: material})
    end
  end

  # get material by type
  swagger_path :showByType do
    get("/materials/type/{id}")
    summary("Get material by type id")
    description("Material filtered by type id")
    parameter :id, :path, :integer, "Id of type of the material to be displayed", required: true
    response(code(:ok), "Success")
  end

  def showByType(conn, %{"id" => id}) do
    materials = Repo.all(from m in Material, select: m, where: m.material_type_id == ^id)
    if materials == [] do
      Logger.error("le type de matériau n'existe pas")
      put_status(conn, 404)
      |> json([])
    else
      put_status(conn, 200)
      |> MaterialView.render("index.json", %{materials: materials})
    end
  end

  # create material
  swagger_path :create do
    post("/materials")
    summary("Create Material")
    description("Create a new Material")
    produces "application/json"
    parameter :material, :body, Schema.ref(:Material), "Material", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
      material_type_id: 1,
      name: "Pierre"
    })
  end

  def create(conn, params) do
    material_type_id = params["material_type_id"]
    name = params["name"]
    case Repo.insert %Material{material_type_id: material_type_id, name: name} do
      {:ok, material} ->
        put_status(conn, 201)
        |> MaterialView.render("index.json", %{material: material})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

  # update material
  swagger_path :update do
    put("/materials/{id}")
    summary("Update material")
    description("Update an existing Material")
    produces "application/json"
    parameter :id, :path, :integer, "Id of the material to be updated", required: true
    parameter :material, :body, Schema.ref(:Material), "Changes in material", required: true, default: Jason.Formatter.pretty_print(Jason.encode!%{
        material_type_id: 1,
        name: "Argent"
      }
    )
  end

  def update(conn, params) do
    material = Repo.get!(Material, params["id"])
    material_type_id = params["material_type_id"] || material.material_type_id
    name = params["name"] || material.name
    case Repo.update Material.changeset(material, %{material_type_id: material_type_id, name: name}) do
      {:ok, material} ->
        put_status(conn, 200)
        |> MaterialView.render("index.json", %{material: material})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end

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
        put_status(conn, 200)
        |> MaterialView.render("index.json", %{material: material})
      {:error, changeset} ->
        Logger.error changeset
        put_status(conn, 500)
    end
  end
end
