defmodule WireGuard.Repo.Migrations.CreatePeersSequence do
  use Ecto.Migration

  def up do
    execute """
      CREATE SEQUENCE peer_sequence START 1;
    """
  end

  def down do
    execute """
      DROP SEQUENCE peer_sequence;
    """
  end
end
