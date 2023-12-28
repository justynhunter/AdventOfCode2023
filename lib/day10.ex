defmodule Day10.Part1 do
  def solve(path) do
    grid =
      File.read!(path)
      |> String.split("\n", trim: true)
      |> Enum.map(&String.graphemes/1)

    start_pos = find_start(grid)

    start(grid, start_pos)
    |> Enum.max()
    |> Kernel.div(2)
  end

  def find_start(grid) do
    {row, row_idx} =
      grid
      |> Enum.with_index()
      |> Enum.find(fn {row, _index} -> Enum.member?(row, "S") end)

    {row_idx, row |> Enum.find_index(&(&1 == "S"))}
  end

  def item_at(grid, x, y), do: grid |> Enum.at(x) |> Enum.at(y)

  def start(grid, {x, y}) do
    [{1, 0}, {0, 1}, {-1, 0}, {0, -1}]
    |> Enum.filter(fn {dx, dy} ->
      x + dx >= 0 and x + dx < length(grid) and
        y + dy >= 0 and y + dy < length(Enum.at(grid, 0))
    end)
    |> Enum.map(fn {dx, dy} ->
      follow_path({x + dx, y + dy, get_dir({dx, dy})}, grid, 1)
    end)
  end

  def get_dir({dx, dy}) do
    case {dx, dy} do
      {1, 0} -> "N"
      {0, 1} -> "E"
      {-1, 0} -> "S"
      {0, -1} -> "W"
    end
  end

  def west(x, y), do: {x, y - 1, "W"}
  def east(x, y), do: {x, y + 1, "E"}
  def north(x, y), do: {x - 1, y, "N"}
  def south(x, y), do: {x + 1, y, "S"}

  def follow_path({x, y, dir}, grid, count) do
    pipe = grid |> Enum.at(x) |> Enum.at(y)

    case {pipe, dir} do
      {"-", "E"} -> {:ok, east(x,y)}
      {"-", "W"} -> {:ok, west(x,y)}
      {"|", "N"} -> {:ok, north(x, y)}
      {"|", "S"} -> {:ok, south(x, y)}
      {"7", "N"} -> {:ok, west(x, y)}
      {"7", "E"} -> {:ok, south(x, y)}
      {"F", "W"} -> {:ok, south(x, y)}
      {"F", "N"} -> {:ok, east(x, y)}
      {"L", "S"} -> {:ok, east(x, y)}
      {"L", "W"} -> {:ok, north(x,y)}
      {"J", "E"} -> {:ok, north(x, y)}
      {"J", "S"} -> {:ok, west(x, y)}
      {"S", _} -> {:done, count}
      _ -> {:done, 0}
    end
    |> (fn r ->
          case r do
            {:ok, next} -> follow_path(next, grid, count + 1)
            {:done, c} -> c
          end
        end).()
  end
end

defmodule Day10.Part2 do
  def solve(path) do
    File.read!(path)
    |> String.split("\n", trim: true)

    0
  end
end

defmodule Mix.Tasks.Day10 do
  use Mix.Task

  def run(_) do
    path = "inputs/day10-input.txt"
    IO.puts("Part 1: " <> (Day10.Part1.solve(path) |> Integer.to_string()))
    IO.puts("Part 2: " <> (Day10.Part2.solve(path) |> Integer.to_string()))
  end
end
