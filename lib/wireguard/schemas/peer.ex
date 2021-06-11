defmodule WireGuard.Schemas.Peer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:address, :public_key]

  schema "peers" do
    field :address, :string
    field :public_key, :string
    field :preshared_key, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:address])
    |> unique_constraint([:public_key])
  end
end
