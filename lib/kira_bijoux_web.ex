defmodule KiraBijouxWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use KiraBijouxWeb, :controller
     use KiraBijouxWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: KiraBijouxWeb

      import Plug.Conn
      import Plug.Conn.Status, only: [code: 1]
      import KiraBijouxWeb.Gettext
      import Ecto.Query, only: [from: 2]
      import Logger
      use PhoenixSwagger

      alias KiraBijouxWeb.Router.Helpers, as: Routes
      alias KiraBijoux.{Admin, Article, Collection, Component, Item, Material, Order, Page, Repo, Template, User}
      alias KiraBijouxWeb.{ItemView, UserView}
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/kira_bijoux_web/templates",
        namespace: KiraBijouxWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1, json: 2]

      alias KiraBijoux.{Admin, Article, Collection, Component, Item, Material, Order, Page, Repo, Template, User}
      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def migration do
    quote do
      use Ecto.Migration
      alias KiraBijoux.{Admin, Article, Collection, Component, Item, Material, Order, Page, Repo, Template, User}
      import Ecto.Query, only: [from: 2]

    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import KiraBijouxWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import Ecto.Query, only: [from: 2]
      import KiraBijouxWeb.ErrorHelpers
      import KiraBijouxWeb.Gettext
      alias KiraBijouxWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
