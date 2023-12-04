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
    |> Enum.filter(fn {start_index, len} -> is_valid(symbol_map, line_index, start_index, (start_index + len - 1)) end)
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
    || Enum.any?(curr_line, &(&1 == (start_index - 1)))
    || Enum.any?(curr_line, &(&1 == (end_index + 1)))
  end
end

defmodule Day03.Part2 do
  def solve(file_contents) do
    lines = String.split(file_contents, "\n", trim: true)

    number_map = Enum.map(lines, &map_numbers/1)

    lines
    |> Enum.with_index()
    |> Enum.flat_map(&(find_gear(&1, number_map, lines)))
    |> Enum.sum()
    |> Integer.to_string()
  end

  def find_gear({line, line_index}, number_map, lines) do
    Regex.scan(~r/\*/, line, return: :index)
    |> List.flatten()
    |> Enum.map(fn {start_index, _} -> valid_nums(number_map, line_index, start_index, lines) end)
  end

  def gear_ratio([{num1_start, num1_len}, {num2_start, num2_len}], line) do
    (line |> Enum.slice(num1_start..(num1_start + num1_len - 1)) |> Enum.join("") |> String.to_integer())
    * (line |> Enum.slice(num2_start..(num2_start + num2_len - 1)) |> Enum.join("") |> String.to_integer())
  end

  def valid_nums(number_map, line_index, gear_index, lines) do
    curr_line = Enum.at(number_map, line_index)

    nums_above = if line_index == 0 do [] else
      number_map
      |> Enum.at(line_index - 1)
      |> Enum.filter(fn {start, len} -> gear_index >= (start - 1) and gear_index <= (start + len) end)
      |> Enum.map(fn {start, len} -> lines |> Enum.at(line_index - 1) |> parse_number(start, len) end)
    end

    nums_below = if line_index >= Enum.count(number_map) do [] else
      number_map
      |> Enum.at(line_index + 1)
      |> Enum.filter(fn {start, len} -> gear_index >= (start - 1) and gear_index < (start + len) end)
      |> Enum.map(fn {start, len} -> lines |> Enum.at(line_index + 1) |> parse_number(start, len) end)
    end

    nums_before = if gear_index == 0 do [] else
      curr_line
      |> Enum.filter(fn {start, len} -> gear_index - 1 <= (start + len - 1) end)
      |> Enum.map(fn {start, len} -> lines |> Enum.at(line_index) |> parse_number(start, len) end)
    end

    nums_after = if gear_index >= Enum.count(curr_line) do [] else
      curr_line
      |> Enum.filter(fn {start, _} -> start == (gear_index + 1) end)
      |> Enum.map(fn {start, len} -> lines |> Enum.at(line_index) |> parse_number(start, len) end)
    end

    nums = nums_above ++ nums_below ++ nums_before ++ nums_after

    if Enum.count(nums) == 2 do Enum.reduce(nums, fn x, y -> x * y end)
    else 0 end
  end

  def parse_number(line, index, len) do
    line
    |> String.graphemes()
    |> Enum.slice(index..(index + len - 1))
    |> Enum.join("")
    |> String.to_integer()
  end

  def map_numbers(line) do
    Regex.scan(~r/\d+/, line, return: :index)
    |> List.flatten()
  end
end

defmodule Mix.Tasks.Day03 do
  use Mix.Task

  def run(_) do
    path = "inputs/day03-input.txt"
    {:ok, lines} = File.read(path)

    IO.puts("Part 1: " <> Day03.Part1.solve(lines))
    IO.puts("Part 2: " <> Day03.Part2.solve(lines))
  end
end
