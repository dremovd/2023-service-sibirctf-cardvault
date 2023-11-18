defmodule CardVault.Tools.Redis do
  def fetch(key) do
    case Redix.command(:redix, ["GET", key]) do
      {:ok, nil} -> {:error, "Payment for token #{key} not found"}
      {:ok, data} -> {:ok, data}
    end
  end

  def fetch!(key) do
    {:ok, data} = fetch(key)
    data
  end

  def put(key, value, expire_sec \\ Application.fetch_env!(:cardvault, :ttl_minutes) * 60) do
    commands = [
      ["SET", key, value],
      ["EXPIRE", key, expire_sec]
    ]

    case Redix.transaction_pipeline(:redix, commands) do
      {:ok, _} -> :ok
      _ -> {:error, "Can not execute"}
    end
  end

  def list(terminal_key) do
    case Redix.command(:redix, ["KEYS", "#{terminal_key}:*"]) do
      {:ok, data} -> {:ok, data}
    end
  end

  def list() do
    case Redix.command(:redix, ["KEYS", "*"]) do
      {:ok, data} -> {:ok, data}
    end
  end

  def delete(key) do
    Redix.command(:redix, ["GETDEL", key])
  end
end
