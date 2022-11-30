defmodule Advent.DayTest do
  use ExUnit.Case

  alias Advent.Day

  test "parse input" do
    # assert Day.parse_input() |> hd() |> String.valid?()
  end

  test "exec" do
    assert Day.exec() == :ok
  end

  test "parse step" do
    step = "on x=10..12,y=10..12,z=10..12"
    {cmd, _} = Day.parse_step(step)
    assert cmd == "on"
  end

  test "fetch cubes" do
    step = "on x=10..12,y=10..12,z=10..12"
    range=-50..50
    cubes = Day.fetch_cubes(step, range)
    assert cubes|>Map.keys()|>Enum.count() == 27
    assert cubes|>Enum.take(1) |> hd()|>elem(1) == 1
  end

  test "range_cubes" do
    range = -5..5
    assert Day.range_cubes(range) |> Map.has_key?({-5,-5,-5})
  end

  test "apply_step" do
    step = "on x=10..12,y=10..12,z=10..12"
    range=-50..50
    cubes = Day.range_cubes(range)
    apply_cubes = Day.fetch_cubes(step, range)
    apply_cubes_count = map_size(apply_cubes)
    result = Day.apply_step(cubes, step, range)
    assert Day.count_on(result) == apply_cubes_count
  end

  # @tag run: true
  test "apply_steps" do
    steps = [
      "on x=10..12,y=10..12,z=10..12",
      "on x=11..13,y=11..13,z=11..13",
    ]
    range=-50..50
    cubes = Day.range_cubes(range)
    after_apply = Day.apply_steps(cubes, steps, range)
    assert Day.count_on(after_apply) == 27+19

    steps = [
      "on x=10..12,y=10..12,z=10..12",
      "on x=11..13,y=11..13,z=11..13",
      "off x=9..11,y=9..11,z=9..11"
    ]
    after_apply = Day.apply_steps(cubes, steps, range)
    assert Day.count_on(after_apply) == 27+19-8

    steps = [
      "on x=10..12,y=10..12,z=10..12",
      "on x=11..13,y=11..13,z=11..13",
      "off x=9..11,y=9..11,z=9..11",
      "on x=10..10,y=10..10,z=10..10"
    ]
    after_apply = Day.apply_steps(cubes, steps, range)
    assert Day.count_on(after_apply) == 39
  end

  # @tag run: true
  test "larger example" do
    steps = Day.parse_input("./input2.txt")
    range=-50..50
    cubes = Day.range_cubes(range)
    after_apply = Day.apply_steps(cubes, steps, range)
    assert Day.count_on(after_apply) == 590784
  end

  # @tag run: true
  test "part1 example" do
    steps = Day.parse_input("./input.txt")
    range=-50..50
    cubes = Day.range_cubes(range)
    after_apply = Day.apply_steps(cubes, steps, range)
    # 644257
    assert Day.count_on(after_apply) == 0
  end
 
  @tag run: true
  test "cal region" do
    old = %{off: [
      {{-50,50},{-50,50},{-50,50}}
    ], on: []}
    new = %{on: [
      {{-10,10},{-10,10},{-10,10}}
    ]}
    old_region=old|>Map.get(:off)|>hd()
    new_region=new|>Map.get(:on)|>hd()
    assert Day.include?(old_region, new_region)
    # next = Day.cal_region(old, new)
    # assert next == 
  end
end
