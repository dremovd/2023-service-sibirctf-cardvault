defmodule PaymentTest do
  use ExUnit.Case

  test "validates CORRECT Payment structure" do
    {:ok,
     %{
       token: token,
       amount: amount,
       order_id: _,
       terminal_key: terminal_key,
       card: %{
         cvv: cvv,
         cardholder: cardholder,
         exp_date_year: exp_date_year,
         exp_date_month: exp_date_month,
         pan: pan
       },
       items: [_]
     }} =
      CardVault.Model.Payment.create("SouthParkBankTest", %{
        "amount" => 0.1,
        "items" => [
          %{
            "description" => "Fork",
            "price" => 0.1
          }
        ],
        "order_id" => "89551776854",
        "card" => %{
          "pan" => "2223000048410010",
          "exp_date_month" => "10",
          "exp_date_year" => "29",
          "cvv" => "321",
          "cardholder" => "ERIK CARTMAN"
        }
      })

    assert cvv == "321"
    assert cardholder == "ERIK CARTMAN"
    assert exp_date_year == "29"
    assert exp_date_month == "10"
    assert pan == "2223000048410010"
    assert terminal_key == "SouthParkBankTest"
    assert is_bitstring(token)
    assert amount == 0.1
  end
end
