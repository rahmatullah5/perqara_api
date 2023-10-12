defmodule PerqaraApiWeb.RateLimitPlug do
  @moduledoc false
  import Plug.Conn
  alias PerqaraApiWeb.FallbackController

  @spec init(any) :: any
  def init(options), do: options

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    hammer_config = get_hammer_config()

    case Hammer.check_rate(
           client_ip_address(conn),
           hammer_config[:bucket_size_in_ms],
           1000
         ) do
      {:allow, _count} ->
        conn

      {:deny, _limit} ->
        conn
        |> FallbackController.call({:error, :too_many_requests})
        |> halt()
    end
  end

  defp client_ip_address(conn) do
    conn.remote_ip |> :inet.ntoa() |> to_string()
  end

  defp get_hammer_config do
    Application.get_env(:perqara_api, :hammer)
  end
end
