defmodule Wireguard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Wireguard.Repo,
      # Start the Telemetry supervisor
      WireguardWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Wireguard.PubSub},
      # Start the Endpoint (http/https)
      WireguardWeb.Endpoint
      # Start a worker by calling: Wireguard.Worker.start_link(arg)
      # {Wireguard.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Wireguard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WireguardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
