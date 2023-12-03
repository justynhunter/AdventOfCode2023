defmodule Day02.Part1 do
  def solve(path) do
    File.stream!(path)
    |> Stream.map(fn line ->
      (is_valid?(line, "red", 12)
        && is_valid?(line, "green", 13)
        && is_valid?(line, "blue", 14))
      |> get_id(line)
    end)
    |> Enum.sum()
    |> Integer.to_string()
  end

  defp get_id(false, _), do: 0
  defp get_id(true, line) do
    Regex.scan(~r/Game (\d*):/, line)
    |> List.flatten()
    |> Enum.at(1)
    |> String.to_integer()
  end

  defp is_valid?(line, color, max) do
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

  defp max_value(line, color) do
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
    path = "inputs/day02-input.txt"
    IO.puts("Part 1: " <> Day02.Part1.solve(path))
    IO.puts("Part 2: " <> Day02.Part2.solve(path))
  end
end
