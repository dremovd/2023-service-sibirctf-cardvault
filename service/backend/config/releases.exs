import Config

config :cardvault,
  env_port: (case System.fetch_env("PORT") do
              {:ok, port} -> String.to_integer(port)
              :error -> nil
            end),
  env_ttl_minutes: (case System.fetch_env("TTL_MINUTES") do
                      {:ok, minutes} -> String.to_integer(minutes)
                      :error -> nil
                    end),
  master_key: :crypto.mac(:hmac, :sha256, :crypto.strong_rand_bytes(0), :crypto.strong_rand_bytes(1)),
  redis_host: (case System.fetch_env("REDIS_HOST") do
              {:ok, host} -> host
              :error -> "localhost"
            end),
  redis_port: (case System.fetch_env("REDIS_PORT") do
                      {:ok, port} -> String.to_integer(port)
                      :error -> 6379
                    end)
