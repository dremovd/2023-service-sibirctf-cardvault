defmodule CardVault.Application do
  use Supervisor
  use Application

  require Logger

  def init(_) do
  end

  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http, plug: CardVault.Router, options: [port: get_config(:env_port, :port)]
      },
      {
        Redix,
        name: :redix,
        port: Application.fetch_env!(:cardvault, :redis_port),
        host: Application.fetch_env!(:cardvault, :redis_host)
      }
    ]

    opts = [strategy: :one_for_one, name: CardVault.Supervisor]

    Logger.info(
      "Starting application: PORT: #{get_config(:env_port, :port)} | TTL_MINUTES: #{get_config(:env_ttl_minutes, :ttl_minutes)}"
    )

    Supervisor.start_link(children, opts)
  end

  defp get_config(env_param, param) do
    case Application.fetch_env(:cardvault, env_param) do
      {:ok, nil} -> Application.fetch_env!(:cardvault, param)
      {:ok, param} -> param
      _ -> Application.fetch_env!(:cardvault, param)
    end
  end
end
