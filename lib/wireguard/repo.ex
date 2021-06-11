defmodule Wireguard.Repo do
  use Ecto.Repo,
    otp_app: :wireguard,
    adapter: Ecto.Adapters.Postgres
end
