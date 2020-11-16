defmodule KiraBijoux.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      KiraBijoux.Repo,
      # Start the Telemetry supervisor
      KiraBijouxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: KiraBijoux.PubSub},
      # Start the Endpoint (http/https)
      KiraBijouxWeb.Endpoint
      # Start a worker by calling: KiraBijoux.Worker.start_link(arg)
      # {KiraBijoux.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KiraBijoux.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KiraBijouxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
