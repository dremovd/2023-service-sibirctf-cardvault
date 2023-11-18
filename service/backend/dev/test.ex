Enum.map(Enum.to_list(1..900000), fn _ ->
  :crypto.mac(:hmac, :sha256, :crypto.strong_rand_bytes(1), :crypto.strong_rand_bytes(1))
  |> Base.encode16()
end)
|> Enum.into(MapSet.new())
|> MapSet.size()
