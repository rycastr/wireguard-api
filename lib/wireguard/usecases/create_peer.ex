defmodule WireGuard.UseCases.CreatePeer do
  alias Ecto.Multi
  alias WireGuard.Helpers.IP
  alias WireGuard.Schemas.Peer

  def call(params) do
    Multi.new()
    |> Multi.run(:peer_index, fn repo, _ -> current_peer_sequence(repo) end)
    |> Multi.run(:create_peer, fn repo, %{peer_index: index} ->
      index
      |> IP.id2ip("192.168.1.1/24")
      |> create_peer(repo, params)
    end)
    |> run_transaction()
    |> configure()
  end

  defp current_peer_sequence(repo) do
    repo.query!("SELECT nextval('peer_sequence');")
    |> then(fn %{rows: [[id]]} -> {:ok, id} end)
  end

  defp create_peer({:ok, address}, repo, params) do
    params
    |> Map.put(:address, address)
    |> Peer.changeset()
    |> repo.insert()
  end

  defp run_transaction(trx) do
    case WireGuard.Repo.transaction(trx) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{create_peer: peer}} -> {:ok, peer}
    end
  end

  defp configure({:ok, peer}) do
    peer
  end
end
