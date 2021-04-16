defmodule KiraBijouxWeb.Router do
  use KiraBijouxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KiraBijouxWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/admin", KiraBijouxWeb do
    pipe_through :browser

    get "/", AdminPageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", KiraBijouxWeb do
    pipe_through :api
    get("/users", UserController, :index)
    get("/users/:id", UserController, :show)
    post("/users", UserController, :create)
    put("/users/:id", UserController, :update)
    delete("/users/:id", UserController, :delete)

    get("/address/:id", AddressController, :show)
    post("/address/:id", AddressController, :create)
    put("/address/:user_id/:address_id", AddressController, :update)
    delete("/address/:id", AddressController, :delete)

    get("/items", ItemController, :index)
    get("/items/:id", ItemController, :show)
    get("/items/category/:name", ItemController, :showByCategory)
    get("/items/category/item/:name", ItemController, :showByName)
    post("/items", ItemController, :create)
    put("/items/:id", ItemController, :update)
    delete("/items/:id", ItemController, :delete)

    post("/auth/registration", AuthController, :register)
    post("/auth/connexion", AuthController, :connect)

    get("/shop", ShoppingCartController, :index)
    get("/shop/user/:user_id", ShoppingCartController, :show)
    post("/shop", ShoppingCartController, :create)
    put("/shop/:item_id", ShoppingCartController, :update)
    delete("/shop/:item_id", ShoppingCartController, :delete)

    get("/orders", OrderController, :index)
    get("/orders/:id", OrderController, :show)
    get("/orders/user/:id", OrderController, :showByUserId)
    post("/orders", OrderController, :create)
    put("/orders/:id", OrderController, :update)
    delete("/orders/:id", OrderController, :delete)

    get("/order-items", OrderItemController, :index)
    get("/order-items/:id", OrderItemController, :show)
    get("/order-items/order/:id", OrderItemController, :showByOrderId)
    post("/order-items", OrderItemController, :create)
    put("/order-items/:id", OrderItemController, :update)
    delete("/order-items/:id", OrderItemController, :delete)
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :kira_bijoux,
      swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      basePath: "/api",
      info: %{
        version: "1.0",
        title: "Kira Bijoux API"
      }
    }
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: KiraBijouxWeb.Telemetry
    end
  end
end
