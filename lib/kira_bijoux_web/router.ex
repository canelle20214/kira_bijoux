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

    get("/addresses/:id", AddressController, :show)
    get("/addresses/user/:id", AddressController, :showByUserId)
    post("/addresses/:id", AddressController, :create)
    put("/addresses/:id", AddressController, :update)
    delete("/addresses/:id", AddressController, :delete)

    post("/auth/registration", AuthController, :register)
    post("/auth/connexion", AuthController, :connect)

    get("/collections", CollectionController, :index)
    get("/collections/:id", CollectionController, :show)
    post("/collections", CollectionController, :create)
    put("/collections/:id", CollectionController, :update)
    delete("/collections/:id", CollectionController, :delete)

    get("/items", ItemController, :index)
    get("/items/:id", ItemController, :show)
    get("/items/picture/:id", ItemController, :showPicture)
    get("/items/category/:name", ItemController, :showByCategory)
    get("/items/category/item/:name", ItemController, :showByName)
    post("/items", ItemController, :create)
    put("/items/:id", ItemController, :update)
    delete("/items/:id", ItemController, :delete)

    get("/item-parents", ItemParentController, :index)
    get("/item-parents/:id", ItemParentController, :show)
    get("/item-parents/type/:id", ItemParentController, :showByType)
    get("/item-parents/collection/:id", ItemParentController, :showByCollection)
    post("/item-parents", ItemParentController, :create)
    put("/item-parents/:id", ItemParentController, :update)
    delete("/item-parents/:id", ItemParentController, :delete)

    get("/item-types", ItemTypeController, :index)
    get("/item-types/:id", ItemTypeController, :show)
    post("/item-types", ItemTypeController, :create)
    put("/item-types/:id", ItemTypeController, :update)
    delete("/item-types/:id", ItemTypeController, :delete)

    get("/materials", MaterialController, :index)
    get("/materials/:id", MaterialController, :show)
    get("/materials/type/:id", MaterialController, :showByType)
    post("/materials", MaterialController, :create)
    put("/materials/:id", MaterialController, :update)
    delete("/materials/:id", MaterialController, :delete)

    get("/newsletters", NewsletterController, :index)
    get("/newsletters/:id", NewsletterController, :show)
    post("/newsletters", NewsletterController, :create)
    put("/newsletters/:id", NewsletterController, :update)
    delete("/newsletters/:id", NewsletterController, :delete)

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

    get("/order-status", OrderStatusController, :index)
    get("/order-status/:id", OrderStatusController, :show)
    post("/order-status", OrderStatusController, :create)
    put("/order-status/:id", OrderStatusController, :update)
    delete("/order-status/:id", OrderStatusController, :delete)

    get("/shops", ShoppingCartController, :index)
    get("/shops/:id", ShoppingCartController, :show)
    get("/shops/user-address/:id", ShoppingCartController, :showByUserAddressId)
    post("/shops", ShoppingCartController, :create)
    put("/shops/:item_id/:order_id", ShoppingCartController, :update)
    delete("/shops/:item_id/:order_id", ShoppingCartController, :delete)

    get("/user-newsletters", UserNewsletterController, :index)
    get("/user-newsletters/:id", UserNewsletterController, :show)
    get("/user-newsletters/item/:id", UserNewsletterController, :showByItemId)
    get("/user-newsletters/user/:id", UserNewsletterController, :showByUserId)
    get("/user-newsletters/mail/:mail", UserNewsletterController, :showByMail)
    post("/user-newsletters", UserNewsletterController, :create)
    put("/user-newsletters/:id", UserNewsletterController, :update)
    delete("/user-newsletters/:id", UserNewsletterController, :delete)

    get("/users", UserController, :index)
    get("/users/:id", UserController, :show)
    post("/users", UserController, :create)
    put("/users/:id", UserController, :update)
    delete("/users/:id", UserController, :delete)
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
