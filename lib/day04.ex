defmodule Day04.Part1 do
  def solve(path) do
    File.stream!(path)
    |> Stream.map(&process_line/1)
    |> Enum.sum()
    |> Integer.to_string()
  end

  def process_line(line) do
    String.split(line, ~r/[:|]/, trim: true)
    |> Enum.drop(1)
    |> Enum.map(&(String.trim(&1, "\n") |> String.split(" ", trim: true)))
    |> find_intersections()
    |> (&(if &1 == 0 do 0 else 2 ** (&1-1) end)).()
  end

  def find_intersections([winners, my_nums]) do
    (winners -- my_nums)
    |> (&(winners -- &1)).()
    |> Enum.count()
  end
end

defmodule Day04.Part2 do
  def solve(path) do
    ""
  end
end

defmodule Mix.Tasks.Day04 do
  use Mix.Task

  def run(_) do
    path = "inputs/day04-input.txt"
    IO.puts("Part 1: " <> Day04.Part1.solve(path))
    IO.puts("Part 2: " <> Day04.Part2.solve(path))
  end
end
