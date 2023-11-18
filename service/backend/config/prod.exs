import Config

config :cardvault,
  port: 7000,
  ttl_minutes: 360,
  master_key: :crypto.mac(:hmac, :sha256, :crypto.strong_rand_bytes(0), :crypto.strong_rand_bytes(1)),
  redis_host: (case System.fetch_env("REDIS_HOST") do
              {:ok, host} -> host
              :error -> "localhost"
            end),
  redis_port: (case System.fetch_env("REDIS_PORT") do
                      {:ok, port} -> String.to_integer(port)
                      :error -> 6379
                    end),
  plug_log_level: :warning
