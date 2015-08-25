defmodule Frequency do
  @doc """
  Count word frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: Dict.t
  def frequency(texts, workers) do
    # IO.puts "# of processes: #{length :erlang.processes}"
    texts
    |> divide_to_chunks(workers)
    # Stream.map can't be used on the next line. Otherwise, all the workers will
    # be created at a later time and in a sequential manner.
    |> Enum.map(fn text -> do_work(text) end)
    |> Stream.map(fn task -> harvest(task) end)
    |> Enum.reduce(HashDict.new, fn list_of_dicts, acc ->
      list_of_dicts
      |> Enum.reduce(acc, fn dict, acc2 ->
        Dict.merge(acc2, dict, fn _key, val1, val2 -> val1 + val2 end)
      end)
    end)
  end

  @doc """
  Divide a list of paragraphs into chunks of words. Each paragraph is divided
  into words first. The number of workers is the number of chunks.
  """
  @spec divide_to_chunks([String.t], pos_integer) :: [[String.t]]
  def divide_to_chunks(texts, workers) do
    divide(texts)
    |> chunk(workers)
  end

  @doc """
  Divide a list of paragraphs into words.
  """
  @spec divide([String.t]) :: [String.t]
  def divide([]) do
    []
  end

  def divide(texts) do
    texts
    |> Enum.map(fn text -> String.split(text) end)
    |> List.flatten
  end

  @doc """
  Divide a list of words into chunks based on # of workers.
  """
  def chunk(words, workers) when length(words) < workers do
    [words]
  end

  def chunk(words, workers) do
    chunk_size = round(length(words) / workers)
    words
    |> Stream.chunk(chunk_size, chunk_size, [])
  end

  def do_work(text) do
    Task.async(fn ->
      # :timer.sleep 2000
      # IO.puts "# of processes: #{length :erlang.processes}"
      count_words(text)
    end)
  end

  def harvest(task) do
    Task.await task
  end

  def count_words(text) do
    text
    |> Stream.map(&String.downcase/1)
    |> Stream.map(&count_word/1)
  end

  def count_word(word) do
    word
    |> String.codepoints
    |> Stream.filter(fn letter ->
      Regex.match?(~r/\w/u, letter) and not Regex.match?(~r/\d/, letter)
    end)
    |> Enum.reduce(HashDict.new, fn letter, dict ->
      if Dict.has_key?(dict, letter) do
        Dict.put(dict, letter, dict[letter] + 1)
      else
        Dict.put(dict, letter, 1)
      end
    end)
  end
end
