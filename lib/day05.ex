defmodule Day05.Part1 do
  def solve(path) do
    lines =
      File.read!(path)
      |> String.split("\n")

    mappings =
      lines
      |> Enum.drop(2)
      |> Enum.chunk_by(fn l -> l == "" end)
      |> Enum.filter(&(&1 != [""]))
      |> Enum.map(&parse_mapping_block/1)

    lines
    |> Enum.at(0)
    |> String.split(" ")
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&process_seed(&1, mappings))
    |> Enum.min()
    |> (&Integer.to_string/1).()
  end

  def process_seed(source, []), do: source

  def process_seed(source, [mappings | rest]) do
    case Enum.find(mappings, &(source >= elem(&1, 0) && source <= elem(&1, 1))) do
      {start, _, dest} -> process_seed(source - start + dest, rest)
      _ -> process_seed(source, rest)
    end
  end

  def parse_mapping_block(lines) do
    lines
    |> Enum.drop(1)
    |> Enum.map(fn line ->
      [dest, source, len] =
        line
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)

      {source, source + len - 1, dest}
    end)
  end
end

defmodule Day05.Part2 do
  def solve(path) do
    path
  end

  def parse_seeds("seeds: " <> seeds) do
    seeds
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start, len] -> start..(start + len - 1) end)
  end
end

defmodule Mix.Tasks.Day05 do
  use Mix.Task

  def run(_) do
    path = "inputs/day05-input.txt"
    IO.puts("Part 1: " <> Day05.Part1.solve(path))
    # IO.puts("Part 2: " <> Day05.Part2.solve(path))
  end
end
