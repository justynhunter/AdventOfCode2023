defmodule Day08.Part1 do
  def solve(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> parse_lines()
    |> (fn [instructions, maps] ->
          process(instructions, instructions, Enum.at(maps, 0).from, maps, 0)
        end).()
  end

  def parse_lines(lines) do
    instructions =
      lines
      |> Enum.at(0)
      |> String.graphemes()
      |> Enum.map(fn c ->
        case c do
          "L" -> :left
          "R" -> :right
        end
      end)

    maps =
      lines
      |> Enum.drop(1)
      |> Enum.map(fn line ->
        [[_, from, left, right]] =
          Regex.scan(~r/([A-Za-z]*) = \(([A-Za-z]*), ([A-Za-z]*)\)/, line)

        %{from: from, left: left, right: right}
      end)

    [instructions, maps]
  end

  def process(_, _, "ZZZ", _, count), do: count

  def process([], dirs, current, maps, count), do: process(dirs, dirs, current, maps, count)

  def process([lr | instructions], dirs, current, maps, count) do
    maps
    |> Enum.find(fn map -> map.from == current end)
    |> (fn m -> process(instructions, dirs, m[lr], maps, count + 1) end).()
  end
end

defmodule Day08.Part2 do
  def solve(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end

defmodule Mix.Tasks.Day08 do
  use Mix.Task

  def run(_) do
    path = "inputs/day08-input.txt"
    IO.puts("Part 1: " <> (Day08.Part1.solve(path) |> Integer.to_string()))
    IO.puts("Part 2: " <> (Day08.Part2.solve(path) |> Integer.to_string()))
  end
end
