defmodule Day01.Part1 do
  def solve(_input) do
    0
  end
end

defmodule Day01.Part2 do
  def solve(_input) do
    0
  end
end

defmodule Mix.Tasks.Day01 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day01-input.txt")

    IO.puts("### PART 1 ###")
    IO.puts(Day01.Part1.solve(input))
    IO.puts("")
    IO.puts("### PART 2 ###")
    IO.puts(Day01.Part2.solve(input))
  end

end
