defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> String.split("", trim: true)
    |> Stream.filter(fn l -> l end)
    |> encode_letter()
  end

  defp encode_letter(letter) do

  end
end
