defmodule AesTest do
  use ExUnit.Case

  test "decrypt encrypted text is the same" do
    text = "sibirctf"
    assert CardVault.Tools.Aes.decrypt!(CardVault.Tools.Aes.encrypt!(text)) == text
  end
end
