defmodule Day02Test do
  use ExUnit.Case

  test "part1 test" do
    assert Day02.Part1.solve("inputs/day02-test.txt") == "8"
  end

  test "part2 test" do
    assert Day02.Part2.solve("inputs/day02-test.txt") == "2286"
  end
end
