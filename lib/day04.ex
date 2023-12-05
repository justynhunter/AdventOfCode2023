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
    lines = File.read!(path) |> String.split("\n", trim: true)

    initial_score = 1..Enum.count(lines) |> Enum.to_list() |> Enum.reduce(%{}, fn i,acc -> Map.put(acc, i, 1) end)

    lines
    |> Enum.reduce(initial_score, fn line, acc ->
      parse_line(line)
      |> score_card(acc)
    end)
    |> Enum.reduce(0, fn {_k, v}, acc -> acc + v end)
    |> Integer.to_string()
  end

  def score_card(card, tally) do
    intersections = find_intersections(card[:card])

    if intersections != 0 do
      Enum.to_list((card.num + 1)..(card.num + find_intersections(card[:card])))
      |> Enum.reduce(tally, fn x, acc -> %{acc | x => acc[x] + acc[card.num]} end)
    else tally end
  end

  def find_intersections([winners, my_nums]) do
    (winners -- my_nums)
    |> (&(winners -- &1)).()
    |> Enum.count()
  end

  def parse_line(line) do
    %{
      num: Regex.run(~r/Card\s+(\d*):/, line) |> List.last() |> String.to_integer(),
      card: String.split(line, ~r/[:|]/, trim: true) |> Enum.drop(1) |> Enum.map(&(String.trim(&1, "\n") |> String.split(" ", trim: true)))
    }
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
