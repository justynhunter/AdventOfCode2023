defmodule Day08.Part1 do
  def solve(path) do
    {dirs, maps} =
      path
      |> File.read!()
      |> String.split("\n", trim: true)
      |> parse_lines()

    process(dirs, dirs, "AAA", maps, 0)
  end

  def parse_lines([lrs | mappings]) do
    dirs =
      lrs
      |> String.graphemes()
      |> Enum.map(fn c ->
        if c == "L" do
          :left
        else
          :right
        end
      end)

    maps = Enum.map(mappings, &parse_mapping/1)
    {dirs, maps}
  end

  def process(_, _, "ZZZ", _, count), do: count

  def process([], dirs, current, maps, count), do: process(dirs, dirs, current, maps, count)

  def process([lr | dirs], all_dirs, current, maps, count) do
    maps
    |> Enum.find(fn map -> map.from == current end)
    |> (fn m -> process(dirs, all_dirs, m[lr], maps, count + 1) end).()
  end

  def parse_mapping(mapping) do
    [[_, from, left, right]] = Regex.scan(~r/([A-Za-z]*) = \(([A-Za-z]*), ([A-Za-z]*)\)/, mapping)
    %{from: from, left: left, right: right}
  end
end

defmodule Day08.Part2 do
  def solve(path) do
    {dirs, maps} =
      path
      |> File.read!()
      |> String.split("\n", trim: true)
      |> parse_lines()

    starts =
      maps
      |> Enum.filter(&String.ends_with?(&1.from, "A"))
      |> Enum.map(& &1.from)

    process(dirs, dirs, starts, maps, 0)
  end

  def process([], all, current, maps, count), do: process(all, all, current, maps, count)

  def process([lr | dirs], all, current, maps, count) do
    if Enum.all?(current, &String.ends_with?(&1, "Z")) do
      count
    else
      maps
      |> Enum.filter(fn map -> Enum.any?(current, &(&1 == map.from)) end)
      |> (fn m -> process(dirs, all, Enum.map(m, & &1[lr]), maps, count + 1) end).()
    end
  end

  def parse_lines([lrs | mappings]) do
    dirs =
      lrs
      |> String.graphemes()
      |> Enum.map(fn c ->
        if c == "L" do
          :left
        else
          :right
        end
      end)

    maps = Enum.map(mappings, &parse_mapping/1)
    {dirs, maps}
  end

  def parse_mapping(mapping) do
    [[_, from, left, right]] =
      Regex.scan(
        ~r/([A-Z0-9][A-Z0-9][A-Z0-9]) = \(([A-Z0-9][A-Z0-9][A-Z0-9]), ([A-Z0-9][A-Z0-9][A-Z0-9])\)/,
        mapping
      )

    %{from: from, left: left, right: right}
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
