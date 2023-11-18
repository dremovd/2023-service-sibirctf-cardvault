defmodule CardTest do
  use ExUnit.Case

  test "validates EMPTY pan" do
    assert CardVault.Model.Card.create(nil, "10", "10", "123", "ERIC CARTMAN") ==
             {:error, "pan is empty"}
  end

  test "validates WRONG pan" do
    assert CardVault.Model.Card.create("4040", "10", "10", "123", "ERIC CARTMAN") ==
             {:error, "Invalid pan"}
  end

  test "validates EMPTY exp_date_year" do
    assert CardVault.Model.Card.create("4242424242424242", nil, "10", "123", "ERIC CARTMAN") ==
             {:error, "exp_date_year is empty"}
  end

  test "validates WRONG exp_date_year" do
    assert CardVault.Model.Card.create("4242424242424242", "111111", "10", "123", "ERIC CARTMAN") ==
             {:error, "Invalid exp_date_year"}
  end

  test "validates EMPTY exp_date_month" do
    assert CardVault.Model.Card.create("4242424242424242", "10", nil, "123", "ERIC CARTMAN") ==
             {:error, "exp_date_month is empty"}
  end

  test "validates WRONG exp_date_month" do
    assert CardVault.Model.Card.create("4242424242424242", "10", "11111", "123", "ERIC CARTMAN") ==
             {:error, "Invalid exp_date_month"}
  end

  test "validates EMPTY cvv" do
    assert CardVault.Model.Card.create("4242424242424242", "10", "10", nil, "ERIC CARTMAN") ==
             {:error, "cvv is empty"}
  end

  test "validates EMPTY cardholder" do
    assert CardVault.Model.Card.create("4242424242424242", "10", "10", "123", nil) ==
             {:error, "cardholder is empty"}
  end

  test "validates WRONG cardholder" do
    assert CardVault.Model.Card.create("4242424242424242", "10", "10", "123", "&") ==
             {:error, "Invalid cardholder"}
  end

  test "validates CORRECT card structure" do
    {:ok,
     %CardVault.Model.Card{
       cardholder: cardholder,
       cvv: cvv,
       exp_date_month: exp_date_month,
       exp_date_year: exp_date_year,
       pan: pan
     }} = CardVault.Model.Card.create("4242424242424242", "10", "10", "123", "ERIC CARTMAN")

    assert pan == "4242424242424242"
    assert exp_date_month == "10"
    assert exp_date_year == "10"
    assert cardholder == "ERIC CARTMAN"
    assert cvv == "123"
  end
end
