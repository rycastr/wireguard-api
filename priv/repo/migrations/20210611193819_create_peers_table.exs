defmodule WireGuard.Repo.Migrations.CreatePeersTable do
  use Ecto.Migration

  def change do
    create table "peers" do
      add :address, :string, null: false
      add :public_key, :string, null: false
      add :preshared_key, :string

      timestamps()
    end

    create unique_index(:peers, [:address])
    create unique_index(:peers, [:public_key])
  end
end
