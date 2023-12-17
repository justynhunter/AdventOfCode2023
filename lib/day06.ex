defmodule Day06.Part1 do
  def solve(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> parse_lines()
  end

  def parse_lines(lines) do
    lines
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)
    end)
    |> map_time_and_distance()
    |> Enum.map(&calc/1)
    |> Enum.reduce(&*/2)
  end

  def calc(time_distance) do
    1..time_distance.time
    |> Enum.to_list()
    |> Enum.filter(fn i -> i * (time_distance.time - i) > time_distance.distance end)
    |> Enum.count()
  end

  def map_time_and_distance([times, distance]) do
    0..(Enum.count(times) - 1)
    |> Enum.reduce([], fn i, acc ->
      [%{time: Enum.at(times, i), distance: Enum.at(distance, i)} | acc]
    end)
  end
end

defmodule Day06.Part2 do
  def solve(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> parse_lines()
  end

  def parse_lines(lines) do
    lines
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.drop(1)
      |> Enum.join("")
      |> String.to_integer()
    end)
    |> map_time_and_distance()
    |> calc()
  end

  def calc(time_distance) do
    1..time_distance.time
    |> Enum.to_list()
    |> Enum.filter(fn i -> i * (time_distance.time - i) > time_distance.distance end)
    |> Enum.count()
  end

  def map_time_and_distance([times, distance]) do
    %{time: times, distance: distance}
  end
end

defmodule Mix.Tasks.Day06 do
  use Mix.Task

  def run(_) do
    path = "inputs/day06-input.txt"
    IO.puts("Part 1: " <> Integer.to_string(Day06.Part1.solve(path)))
    IO.puts("Part 2: " <> Integer.to_string(Day06.Part2.solve(path)))
  end
end
