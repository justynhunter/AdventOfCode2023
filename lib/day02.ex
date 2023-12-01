defmodule Day02.Part1 do
  def solve(input) do
    ""
  end
end

defmodule Day02.Part2 do
  def solve(input) do
    ""
  end
end

defmodule Mix.Tasks.Day02 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day02Day02-input.txt")
    IO.puts("Part 1: " <> Day02.Part1.solve(input))
    IO.puts("Part 2: " <> Day02.Part2.solve(input))
  end
end
