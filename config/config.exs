# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wireguard,
  ecto_repos: [WireGuard.Repo]

# Configures the endpoint
config :wireguard, WireGuardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wdy7KAihu2I+L8/61OgJpfBck7KIeI9mZoXTft618IIeMoyQFs6NiDDMxh64WjwT",
  render_errors: [view: WireGuardWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: WireGuard.PubSub,
  live_view: [signing_salt: "4eUhp2Ux"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
