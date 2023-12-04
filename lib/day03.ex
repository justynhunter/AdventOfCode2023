defmodule Day03.Part1 do
  def solve(file_content) do
    lines = String.split(file_content, "\n", trim: true)

    symbol_map = Enum.map(lines, &map_symbols/1)

    lines
    |> Enum.with_index()
    |> Enum.map(&(find_num(&1, symbol_map)))
    |> List.flatten()
    |> Enum.sum()
    |> Integer.to_string()
  end

  def map_symbols(line) do
    Regex.scan(~r/[^\.]/, line, return: :index)
    |> List.flatten()
    |> Enum.map(&(elem(&1, 0)))
  end

  def find_num({line, line_index}, symbol_map) do
    Regex.scan(~r/\d+/, line, return: :index)
    |> List.flatten()
    |> Enum.filter(fn {start_index, len} -> is_valid(symbol_map, line_index, start_index, start_index + len - 1) end)
    |> Enum.map(fn {start_index, len} ->
      String.graphemes(line)
      |> Enum.slice(start_index..(start_index + len - 1))
      |> Enum.join("")
      |> String.to_integer()
    end)
  end

  def is_valid(symbol_map, line_index, start_index, end_index) do
    ext_rng = (start_index - 1)..(end_index + 1)
    curr_line = Enum.at(symbol_map, line_index)

    if line_index == 0 do false else Enum.at(symbol_map, line_index - 1) |> Enum.any?(&(&1 in ext_rng)) end
    || if line_index + 1 >= Enum.count(symbol_map) do false else Enum.at(symbol_map, line_index + 1) |> Enum.any?(&(&1 in ext_rng)) end
    || if start_index <= 0 do false else Enum.any?(curr_line, &(&1 == (start_index - 1))) end
    || if (end_index + 1) >= Enum.count(curr_line) do false else Enum.any?(curr_line, &(&1 == (end_index + 1))) end
  end
end

defmodule Mix.Tasks.Day03 do
  use Mix.Task

  def run(_) do
    path = "inputs/day03-input.txt"
    {:ok, lines} = File.read(path)

    IO.puts("Part 1: " <> Day03.Part1.solve(lines))
    # IO.puts("Part 2: " <> Day03.Part2.solve(path))
  end
end
