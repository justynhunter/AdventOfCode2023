defmodule Day02.Part1 do
  def solve(path, max_red, max_green, max_blue) do
    File.stream!(path)
    |> Stream.map(fn line ->
      (is_valid?(line, "red", max_red)
        && is_valid?(line, "green", max_green)
        && is_valid?(line, "blue", max_blue))
      |> get_id(line)
    end)
    |> Enum.sum()
    |> Integer.to_string()
  end

  def get_id(false, _), do: 0
  def get_id(true, line) do
    Regex.scan(~r/Game (\d*):/, line)
    |> List.flatten()
    |> Enum.at(1)
    |> String.to_integer()
  end

  def is_valid?(line, color, max) do
    Regex.scan(Regex.compile!(" (\\d*) #{color}"), line)
    |> Enum.flat_map(fn i -> Enum.slice(i, 1..1) end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.all?(fn i -> i <= max end)
  end
end

defmodule Day02.Part2 do
  def solve(path) do
    File.stream!(path)
    |> Stream.map(fn line ->
      [max_value(line, "red"), max_value(line, "green"), max_value(line, "blue")]
      |> Enum.reduce(fn c, acc -> c * acc end)
    end)
    |> Enum.sum()
    |> Integer.to_string()
  end

  def max_value(line, color) do
    Regex.scan(Regex.compile!(" (\\d*) #{color}"), line)
    |> Enum.reduce(0, fn i, acc ->
      Enum.at(i, 1)
      |> String.to_integer()
      |> case do
        x when x > acc -> x
        _ -> acc
      end
    end)
  end
end

defmodule Mix.Tasks.Day02 do
  use Mix.Task

  def run(_) do
    # IO.puts(Day02.Part1.check_valid("Game 1: 1 red, 3 blue, 11 green; 1 blue, 5 red; 3 blue, 5 green, 13 red; 6 red, 1 blue, 4 green; 16 red, 12 green", "red", 11))
    path = "inputs/day02-input.txt"
    IO.puts("Part 1: " <> Day02.Part1.solve(path, 12, 13, 14))
    IO.puts("Part 2: " <> Day02.Part2.solve(path))
  end
end
