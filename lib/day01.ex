defmodule Day01.Part1 do
  def solve(path) do
    File.stream!(path)
    |> Stream.map(fn line ->
      line
      |> String.replace(~r/[^\d]/, "")
      |> (&(String.slice(&1, 0..0) <> String.slice(&1, -1..-1))).()
      |> String.to_integer()
    end)
    |> Enum.sum
    |> Integer.to_string()
  end
end

defmodule Day01.Part2 do
  def solve(path) do
    File.stream!(path)
    |> Stream.map(fn line ->
      line
      |> String.replace("zero", "z0o")
      |> String.replace("one", "o1e")
      |> String.replace("two", "t2o")
      |> String.replace("three", "t3e")
      |> String.replace("four", "f4r")
      |> String.replace("five", "f5e")
      |> String.replace("six", "s6x")
      |> String.replace("seven", "s7n")
      |> String.replace("eight", "e8t")
      |> String.replace("nine", "n9e")
      |> String.replace(~r/[^\d]/, "")
      |> (&(String.slice(&1, 0..0) <> String.slice(&1, -1..-1))).()
      |> String.to_integer()
    end)
    |> Enum.sum
    |> Integer.to_string()
  end
end

defmodule Mix.Tasks.Day01 do
  use Mix.Task

  def run(_) do
    path = "inputs/day01-input.txt"
    IO.puts("Part 1: " <> Day01.Part1.solve(path))
    IO.puts("Part 2: " <> Day01.Part2.solve(path))
  end

end
