defmodule Day08Test do
  use ExUnit.Case

  test "part1 test" do
    assert Day08.Part1.solve("inputs/day08-test.txt") == 6
  end

  test "part2 test" do
    assert Day08.Part2.solve("inputs/day08-part2-test.txt") == 6
  end
end
