defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates |>
    Enum.filter(fn candidate ->
      not same_word?(base, candidate) and anagram?(base, candidate)
    end)
  end

  defp same_word?(word1, word2) do
    String.downcase(word1) == String.downcase(word2)
  end

  defp anagram?(word1, word2) do
    Enum.sort(String.split(String.downcase(word1), "")) ==
    Enum.sort(String.split(String.downcase(word2), ""))
  end
end
