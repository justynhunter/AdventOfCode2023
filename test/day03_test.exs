defmodule Day03Test do
  use ExUnit.Case

  test "part1 test" do
    assert Day03.Part1.solve(File.read!("inputs/day03-test.txt")) == "4361"
  end

  test "part2 test" do
    assert Day03.Part2.solve(File.read!("inputs/day03-test.txt")) == "467835"
  end
end
