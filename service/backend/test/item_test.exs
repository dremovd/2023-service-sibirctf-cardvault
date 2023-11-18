defmodule ItemTest do
  use ExUnit.Case

  test "validates WRONG description" do
    assert CardVault.Model.Item.create("1", 0.1) ==
             {:error, "Invalid description: 1"}
  end

  test "validates CORRECT card structure" do
    {:ok,
     %CardVault.Model.Item{
       description: description,
       price: price,
       image_url: image_url
     }} = CardVault.Model.Item.create("Afghani Goat", 4.0)

    assert description == "Afghani Goat"
    assert price == 4.0
    assert String.contains?(image_url, "Ic_item_afghani_goat.png")
  end
end
