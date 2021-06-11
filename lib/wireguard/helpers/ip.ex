defmodule WireGuard.Helpers.IP do
  def id2ip(id, net) do
    [net_ip, net_cidr] = String.split(net, "/")

    if calc_cidr(net_cidr) > id do
      net_ip
      |> String.split(".")
      |> Enum.map(fn oct -> String.to_integer(oct, 10) end)
      |> calc_ip(id)
      |> Enum.join(".")
      |> then(&{:ok, "#{&1}/32"})
    else
      {:error, "id is bigger want the cidr"}
    end
  end

  defp calc_cidr(cidr) do
    cidr
    |> String.to_integer(10)
    |> then(&(32 - &1))
    |> then(&Bitwise.bsl(1, &1))
  end

  defp calc_ip(net_ip, id) do
    Enum.map_reduce(net_ip, 3, fn oct, i ->
      Integer.pow(256, i)
      |> then(&Integer.floor_div(id, &1))
      |> rem(256)
      |> then(&(oct + &1))
      |> then(&{&1, i - 1})
    end)
    |> then(fn {ip, _} -> ip end)
  end
end
