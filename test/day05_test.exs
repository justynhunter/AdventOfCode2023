defmodule Day05Test do
  use ExUnit.Case

  test "part1 test" do
    assert Day05.Part1.solve("inputs/day05-test.txt") == "13"
  end

  test "part2 test" do
    assert Day05.Part2.solve("inputs/day05-test.txt") == "30"
  end
end
