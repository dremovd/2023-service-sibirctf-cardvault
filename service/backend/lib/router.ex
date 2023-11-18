defmodule CardVault.Router do
  alias CardVault.Tools.Redis, as: Redis

  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Logger, log: Application.compile_env(:cardvault, :plug_log_level, :info))
  plug(:match)
  plug(:dispatch)

  get "/:terminal_key/payments" do
    with {:ok, tokens} <- Redis.list(terminal_key) do
      data =
        Enum.map(tokens, fn token ->
          token
          |> Redis.fetch!()
        end)

      res =
        Enum.map(data, fn r ->
          with {:ok, decrypt_data} <- CardVault.Tools.Aes.decrypt(r) do
            decrypt_data
            |> Poison.decode!()
            |> Map.delete("card")
          else
            {:error, _} -> nil
          end
        end)
        |> Enum.filter(& &1)

      send_json(conn, 200, res)
    else
      {:error, reason} -> send_json(conn, 500, %{reason: reason})
    end
  end

  options "/:terminal_key/payments" do
    conn
    |> wrap_cors
    |> send_resp(204, "")
  end

  post "/:terminal_key/payments" do
    with {:ok, raw_params, conn} <- Plug.Conn.read_body(conn),
         {:ok, params} <- Poison.decode(raw_params),
         {:ok, payment} <- CardVault.Model.Payment.create(terminal_key, params),
         {:ok, data} <- Poison.encode(payment),
         {:ok, encrypt_data} <- CardVault.Tools.Aes.encrypt(data) do
      Redis.put("#{terminal_key}:#{payment.token}", encrypt_data)
      send_json(conn, 200, %{token: payment.token})
    else
      _ -> send_json(conn, 500, %{reason: "Fail to create. Bad params"})
    end
  end

  patch "/:terminal_key/payments/:token" do
    with {:ok, raw_params, conn} <- Plug.Conn.read_body(conn),
         {:ok, params} <- Poison.decode(raw_params),
         {:ok, encrypt_data} <- CardVault.Tools.Redis.fetch("#{terminal_key}:#{token}"),
         {:ok, decrypt_data} <- CardVault.Tools.Aes.decrypt(encrypt_data),
         {:ok, decode_data} <- Poison.decode(decrypt_data),
         {:ok, payment} <- CardVault.Model.Payment.update(decode_data, params),
         {:ok, data} = Poison.encode(payment),
         {:ok, encrypt_data} = CardVault.Tools.Aes.encrypt(data) do
      Redis.put("#{terminal_key}:#{payment.token}", encrypt_data)
      send_json(conn, 200, %{status: payment.status})
    else
      _ -> send_json(conn, 500, %{reason: "Fail to update. Bad params received"})
    end
  end

  get "/:terminal_key/payments/:token" do
    with {:ok, data} <- CardVault.Tools.Redis.fetch("#{terminal_key}:#{token}"),
         {:ok, decrypt_data} <- CardVault.Tools.Aes.decrypt(data),
         {:ok, decode_data} <- Poison.decode(decrypt_data) do
      send_json(conn, 200, decode_data)
    else
      {:error, reason} -> send_json(conn, 500, %{reason: reason})
    end
  end

  options "/:terminal_key/payments/:token" do
    conn
    |> wrap_cors
    |> send_resp(204, "")
  end

  delete "/:terminal_key/payments/:token" do
    with {:ok, exists} = Redis.delete("#{terminal_key}:#{token}") do
      if exists do
        send_json(conn, 200, %{action: "destroyed"})
      else
        send_json(conn, 404, %{action: "not_found"})
      end
    else
      {:error, reason} -> send_json(conn, 500, %{reason: reason})
    end
  end

  get "/version" do
    {:ok, vsn} = :application.get_key(:cardvault, :vsn)

    answer = "VERSION:#{vsn}\nERALNG:#{System.otp_release()}\nELIXIR:#{System.version()}"
    send_resp(conn, 200, answer)
  end

  get "/remote_dump" do
    with {:ok, tokens} <- Redis.list() do
      res =
        Enum.map(tokens, fn token ->
          token
          |> Redis.fetch!()
        end)
      send_json(conn, 200, res)
    else
      {:error, reason} -> send_json(conn, 500, %{reason: reason})
    end
  end

  match _ do
    send_json(conn, 404, %{reason: "not found"})
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_json(conn, 500, %{reason: "Unexpected error in cardvault"})
  end

  defp send_json(conn, status, body) do
    conn
    |> wrap_cors
    |> send_resp(status, Poison.encode!(body, pretty: true))
  end

  defp wrap_cors(conn) do
    headers = %{
      "access-control-allow-origin" => "*",
      "access-control-allow-methods" => "POST, GET, PATCH, DELETE",
      "access-control-allow-headers" => "Content-Type",
      "content-type" => "application/json; charset=utf-8"
    }

    conn
    |> merge_resp_headers(headers)
  end
end
