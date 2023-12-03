defmodule Day01Test do
  use ExUnit.Case

  test "part 1 test" do
    assert Day01.Part1.solve("inputs/day01-part1-test.txt") == "142"
  end

  test "part 2 test" do
    assert Day01.Part2.solve("inputs/day01-part2-test.txt") == "281"
  end
end
