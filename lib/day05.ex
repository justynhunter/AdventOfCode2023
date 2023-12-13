defmodule Day05.Part1 do
  def solve(path) do
    lines = File.read!(path)
    |> String.split("\n")

    mappings = lines
    |> Enum.drop(2)
    |> Enum.chunk_by(fn l -> l == "" end)
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(&parse_mapping_block/1)

    dbg(mappings)

    lines
    |> Enum.at(0)
    |> String.split(" ")
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&(process_seed(&1, mappings, &1)))
    #|> Enum.map(&(process_map(&1, mappings, &1)))
    |> Enum.min_by(fn {_,val} -> val end)
    |> (fn {seed, _} -> Integer.to_string(seed) end).()
    |> dbg()
  end

  def process_seed(source, [], seed), do: {seed, source}
  def process_seed(source, [mappings | rest], seed) do
    IO.puts(source)
    case Enum.find(mappings, &(source in elem(&1, 0))) do
      {start.._, dest} -> process_seed(source-start+dest, rest, seed)
      _ -> process_seed(source, rest, seed);
    end
  end

  def parse_mapping_block(lines) do
    lines
    |> Enum.drop(1)
    |> Enum.map(fn line ->
      [dest, source, len] = line
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

      {source..(source+len-1), dest}
    end)
  end
end

defmodule Day05.Part2 do
  def solve(path) do
    ""
  end
end

defmodule Mix.Tasks.Day05 do
  use Mix.Task

  def run(_) do
    path = "inputs/day05-input.txt"
    IO.puts("Part 1: " <> Day05.Part1.solve(path))
    IO.puts("Part 2: " <> Day05.Part2.solve(path))
  end
end
