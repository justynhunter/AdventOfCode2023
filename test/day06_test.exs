defmodule Day06Test do
  use ExUnit.Case

  test "part1 test" do
    assert Day06.Part1.solve("inputs/day06-test.txt") == 288
  end

  test "part2 test" do
    assert Day06.Part2.solve("inputs/day06-test.txt") == 71503
  end
end
