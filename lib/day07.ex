defmodule Day07.Part1 do
  def solve(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [hand, bid] ->
      [get_frequencies(hand), score_hand(hand), String.to_integer(bid)]
    end)
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {[_, _, bid], i}, acc -> acc + bid * (i + 1) end)
  end

  @cards ~w[2 3 4 5 6 7 8 9 T J Q K A]
  def score_hand(hand) do
    hand
    |> String.graphemes()
    |> Enum.map(fn c -> Enum.find_index(@cards, &(&1 == c)) end)
  end

  def get_frequencies(hand) do
    hand
    |> String.graphemes()
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
  end
end

defmodule Day07.Part2 do
  def solve(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [hand, bid] ->
      [get_frequencies(hand), score_hand(hand), String.to_integer(bid)]
    end)
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {[_, _, bid], i}, acc -> acc + bid * (i + 1) end)
  end

  @cards ~w[J 2 3 4 5 6 7 8 9 T Q K A]
  def score_hand(hand) do
    hand
    |> String.graphemes()
    |> Enum.map(fn c -> Enum.find_index(@cards, &(&1 == c)) end)
  end

  def get_frequencies(hand) do
    jokers =
      hand
      |> String.graphemes()
      |> Enum.filter(&(&1 == "J"))
      |> Enum.count()

    hand
    |> String.graphemes()
    |> Enum.filter(&(&1 != "J"))
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
    |> add_jokers(jokers)
  end

  def add_jokers([], jokers), do: [jokers]
  def add_jokers([m], jokers), do: [m + jokers]
  def add_jokers([m | tail], jokers), do: [m + jokers | tail]
end

defmodule Mix.Tasks.Day07 do
  use Mix.Task

  def run(_) do
    path = "inputs/day07-input.txt"
    IO.puts("Part 1: " <> (Day07.Part1.solve(path) |> Integer.to_string()))
    IO.puts("Part 2: " <> (Day07.Part2.solve(path) |> Integer.to_string()))
  end
end
