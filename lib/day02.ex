defmodule Day02.Part1 do
  def solve(path, max_red, max_green, max_blue) do
    File.stream!(path)
    |> Stream.map(fn line ->
      (check_valid(line, "red", max_red)
      && check_valid(line, "green", max_green)
      && check_valid(line, "blue", max_blue))
      |> get_id(line)
    end)
    |> Enum.sum()
    |> Integer.to_string()
  end

  def get_id(false, _), do: 0
  def get_id(true, line) do
    Regex.scan(~r/Game (\d*):/, line)
    |> List.flatten()
    |> Enum.slice(1..1)
    |> List.first()
    |> String.to_integer()
  end

  def check_valid(line, color, max) do
    regex = Regex.compile!(" (\\d*) #{color}")
    Regex.scan(regex, line)
    |> Enum.flat_map(fn i -> Enum.slice(i, 1..1) end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.any?(fn i -> i > max end)
    |> Kernel.not
  end
end

defmodule Day02.Part2 do
  def solve(path) do
    ""
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
