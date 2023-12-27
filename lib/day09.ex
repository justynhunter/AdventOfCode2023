defmodule Day09.Part1 do
  def solve(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(&calc_next/1)
    |> Enum.sum()
  end

  defp calc_next(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> (&all_diff([&1])).()
    |> Enum.reduce(0, fn x, acc -> acc + List.last(x) end)
  end

  defp all_diff([curr]), do: all_diff([diffs(curr) | [curr]])

  defp all_diff([curr | nums]) do
    d = diffs(curr)

    if Enum.all?(d, &(&1 == 0)) do
      [d, curr | nums]
    else
      all_diff([d, curr | nums])
    end
  end

  def diffs([]), do: []
  def diffs([_]), do: []

  def diffs([x, y | nums]) do
    [y - x | diffs([y | nums])]
  end
end

defmodule Day09.Part2 do
  def solve(path) do
    0
  end
end

defmodule Mix.Tasks.Day09 do
  use Mix.Task

  def run(_) do
    path = "inputs/day09-input.txt"
    IO.puts("Part 1: " <> (Day09.Part1.solve(path) |> Integer.to_string()))
    IO.puts("Part 2: " <> (Day09.Part2.solve(path) |> Integer.to_string()))
  end
end
