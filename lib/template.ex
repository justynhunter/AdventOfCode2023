defmodule Day00.Part1 do
  def solve(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
  end
end

defmodule Day00.Part2 do
  def solve(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
  end
end

defmodule Mix.Tasks.Day00 do
  use Mix.Task

  def run(_) do
    path = "inputs/day00-input.txt"
    IO.puts("Part 1: " <> (Day00.Part1.solve(path) |> Integer.to_string()))
    IO.puts("Part 2: " <> (Day00.Part2.solve(path) |> Integer.to_string()))
  end
end
