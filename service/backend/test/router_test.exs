defmodule RouterTest do
  use ExUnit.Case
  use Plug.Test

  alias CardVault.Router

  @opts Router.init([])

  test "Response to ping" do
    response =
      conn(:get, "/version")
      |> Router.call([])

    assert response.status == 200
  end

  test "Creates and Get payment info" do
    response = create_payment() |> Router.call(@opts)
    assert response.status == 200
    {:ok, resp} = Poison.decode(response.resp_body)
    {:ok, token} = Map.fetch(resp, "token")
    response = get_payment(token) |> Router.call(@opts)
    assert response.status == 200
    payment_from_response = Poison.Parser.parse!(response.resp_body)

    %{
      "created_at" => _,
      "card" => %{
        "cvv" => cvv,
        "cardholder" => cardholder,
        "exp_date_year" => exp_date_year,
        "exp_date_month" => exp_date_month,
        "pan" => pan
      },
      "amount" => amount,
      "order_id" => order_id,
      "token" => _,
      "items" => _,
      "status" => status
    } = payment_from_response

    assert cvv == "321"
    assert cardholder == "ERIK CARTMAN"
    assert exp_date_year == "28"
    assert exp_date_month == "10"
    assert pan == "4242424242424242"
    assert order_id == "21050"
    assert amount == 0.5
    assert status == "pending"
  end

  test "Creates and Destroys card" do
    response = create_payment() |> Router.call(@opts)
    assert response.status == 200
    {:ok, resp} = Poison.decode(response.resp_body)
    {:ok, token} = Map.fetch(resp, "token")

    response = destroy_card(token) |> Router.call(@opts)
    assert response.status == 200
    assert Map.fetch!(Poison.Parser.parse!(response.resp_body), "action") == "destroyed"
  end

  test "Creates and Get payments" do
    response = create_payment() |> Router.call(@opts)
    assert response.status == 200
    {:ok, resp} = Poison.decode(response.resp_body)
    response = get_payments() |> Router.call(@opts)
    assert response.status == 200
    payments_from_response = Enum.take(Poison.Parser.parse!(response.resp_body), -1)

    [
      %{
        "created_at" => _,
        "amount" => amount,
        "order_id" => _,
        "token" => _,
        "items" => _,
        "terminal_key" => terminal_key,
        "status" => status
      }
    ] = payments_from_response

    assert terminal_key == terminal_key()
    assert amount == 0.55
    assert status == "pending"
  end

  test "Creates and Update card" do
    response = create_payment() |> Router.call(@opts)
    assert response.status == 200
    {:ok, resp} = Poison.decode(response.resp_body)
    {:ok, token} = Map.fetch(resp, "token")

    response = update_card(token) |> Router.call(@opts)
    assert response.status == 200
    assert Map.fetch!(Poison.Parser.parse!(response.resp_body), "status") == "accepted"
  end

  defp terminal_key do
    "SouthParkBankTest"
  end

  defp create_payment do
    :post
    |> conn(
      "/#{terminal_key()}/payments",
      Poison.encode!(%{
        amount: 0.5,
        items: [
          %{
            description: "Asses of Fire 2 poster",
            price: 0.2
          }
        ],
        order_id: "21050",
        card: %{
          pan: "4242424242424242",
          exp_date_month: "10",
          exp_date_year: "28",
          cardholder: "ERIK CARTMAN",
          cvv: "321"
        }
      })
    )
    |> put_req_header("content-type", "application/json")
  end

  defp update_card(token) do
    :patch
    |> conn(
      "/SouthParkBankTest/payments/#{token}",
      Poison.encode!(%{
        status: "accepted"
      })
    )
    |> put_req_header("content-type", "application/json")
  end

  defp get_payment(token) do
    :get
    |> conn("/SouthParkBankTest/payments/#{token}")
    |> put_req_header("content-type", "application/json")
  end

  defp get_payments do
    :get
    |> conn("/SouthParkBankTest/payments")
    |> put_req_header("content-type", "application/json")
  end

  defp find_card(token) do
    :post
    |> conn("/SouthParkBankTest/payments/find", Poison.encode!(%{token: token}))
    |> put_req_header("content-type", "application/json")
  end

  defp destroy_card(token) do
    :delete
    |> conn("/SouthParkBankTest/payments/#{token}")
    |> put_req_header("content-type", "application/json")
  end
end
