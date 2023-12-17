defmodule Day07Test do
  use ExUnit.Case

  test "part1 test" do
    assert Day07.Part1.solve("inputs/day07-test.txt") == 6440
  end

  test "part2 test" do
    assert Day07.Part2.solve("inputs/day07-test.txt") == 5905
  end
end
