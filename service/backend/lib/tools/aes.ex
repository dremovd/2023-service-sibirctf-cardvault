defmodule CardVault.Tools do
  defmodule Aes do
    # Use AES 256 Bit Keys for Encryption.
    @block_size 16

    def encrypt!(ciphertext) do
      {:ok, data} = encrypt(ciphertext)
      data
    end

    def encrypt(plaintext) do
      # create random Initialisation Vector
      iv = :crypto.strong_rand_bytes(16)

      # sample secret_key is a 32 bit hex string
      secret_key =
        Application.fetch_env!(:cardvault, :master_key)

      plaintext = pad(plaintext, @block_size)
      encrypted_text = :crypto.crypto_one_time(:aes_256_cbc, secret_key, iv, plaintext, true)
      encrypted_text = iv <> encrypted_text
      {:ok, :base64.encode(encrypted_text)}
    end

    @spec decrypt(binary() | [1..255]) :: {:error, <<_::144>>} | {:ok, binary()}
    def decrypt(ciphertext) do
      secret_key =
        Application.fetch_env!(:cardvault, :master_key)

      ciphertext = :base64.decode(ciphertext)
      <<iv::binary-16, ciphertext::binary>> = ciphertext

      decrypted_text =
        unpad(:crypto.crypto_one_time(:aes_256_cbc, secret_key, iv, ciphertext, false))

      if String.valid?(decrypted_text) do
        {:ok, decrypted_text}
      else
        {:error, "Can't decrypt data"}
      end
    end

    def decrypt!(ciphertext) do
      {:ok, data} = decrypt(ciphertext)
      data
    end
    
    @spec decrypt_with_key(binary() | [1..255], binary()) :: {:error, <<_::144>>} | {:ok, binary()}
    def decrypt_with_key(ciphertext, secret_key) do
      secret_key_real =
        Application.fetch_env!(:cardvault, :master_key)
      IO.inspect secret_key_real

      ciphertext = :base64.decode(ciphertext)
      <<iv::binary-16, ciphertext::binary>> = ciphertext
      secret_key = :base64.decode(secret_key)
      <<iv::binary-16, ciphertext::binary>> = secret_key

      decrypted_text =
        unpad(:crypto.crypto_one_time(:aes_256_cbc, secret_key, iv, ciphertext, false))

      if String.valid?(decrypted_text) do
        {:ok, decrypted_text}
      else
        {:error, "Can't decrypt data"}
      end
    end

    defp unpad(data) do
      to_remove = :binary.last(data)
      :binary.part(data, 0, byte_size(data) - to_remove)
    end

    # PKCS5Padding
    defp pad(data, block_size) do
      to_add = block_size - rem(byte_size(data), block_size)
      data <> :binary.copy(<<to_add>>, to_add)
    end
  end
end
