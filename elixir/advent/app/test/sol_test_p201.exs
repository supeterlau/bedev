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

  # @tag run: true
  test "larger example" do
  end
 
  # @tag run: true
  test "handle range" do
    t1 = {"on", -50, 50}
    t2 = {"off", -60, 40}
    assert Day.handle_range(t1, t2)|>Map.get("on") == [{41, 50}]
    t1 = {"on", -50, 40}
    t2 = {"off", -60, 40}
    assert Day.handle_range(t1, t2)|>Map.get("on") == []
    t1 = {"on", -50, 50}
    t2 = {"off", -40, 40}
    assert Day.handle_range(t1, t2)|>Map.get("on") == [{-50, -41},{41, 50}]
  end
  
  @tag run: true
  test "run step process" do
# off x=9..11,y=9..11,z=9..11
# on x=10..10,y=10..10,z=10..10
    steps = "on x=10..12,y=10..12,z=10..12
on x=11..13,y=11..13,z=11..13
    "
    steps = steps 
            |> String.trim()
            |> String.split("\n", trim: true)
            |>Day.log()
            |> Enum.map(&(Day.parse_step(&1)))
    Day.log(steps, "steps")
    r1 = {{-50,50}, {-50,50}, {-50,50}}
    state = [
      {"off", r1}
    ]
    r2 = {{10,12}, {10,12}, {10,12}}
    states = Day.process_steps(state, steps)
    # assert states |> length() == 27
    regions = states |> Enum.map(fn {_, v} -> v end)
    assert r1 not in regions
    assert r2 in regions
    # assert Day.count_on(states) == 27
    assert Day.count_on(states) == 27+19
  end

  # @tag run: true
  test "merge same regions" do
    t1 = "on"
    r1 = {{-50,50}, {-50,50}, {-50,50}}
    t2 = "on"
    r2 = {{-60,20}, {-20,20}, {-10,30}}
    states = Day.handle_ranges({t1,r1},{t2,r2})
    states = states |> Enum.map(fn {_, v} -> v end)
    assert states|>length() == 2
    assert {{-60,-51}, {-20,20},{-10,30}} in states
  end

  # @tag run: true
  test "merge diff regions" do
    # t1 = "off"
    # r1 = {{-50,50}, {-50,50}, {-50,50}}
    # t2 = "on"
    # r2 = {{-20,20}, {-20,20}, {-10,30}}
    # {t1rs, t2rs} = Day.handle_ranges({t1,r1},{t2,r2})
    # assert t1rs|>length() == 26
    # assert t2rs|>length() == 1

    t1 = "off"
    r1 = {{-50,50}, {-50,50}, {-50,50}}
    t2 = "on"
    r2 = {{-60,20}, {-20,20}, {-30,30}}
    {{t1, t1rs}, {t2, r2}} = Day.handle_ranges({t1,r1},{t2,r2})
    assert t1rs|>length() == 17

    # t1 = "off"
    # r1 = {{-50,50}, {-50,50}, {-50,50}}
    # t2 = "on"
    # r2 = {{-60,20}, {-70,20}, {-30,30}}
    # {{t1, t1rs}, {t2, r2}} = Day.handle_ranges({t1,r1},{t2,r2})
    # assert t1rs|>length() == 11

    # t1 = "off"
    # r1 = {{-50,50}, {-50,50}, {-50,50}}
    # t2 = "on"
    # r2 = {{-60,20}, {-70,20}, {-30,60}}
    # {{t1, t1rs}, {t2, r2}} = Day.handle_ranges({t1,r1},{t2,r2})
    # assert t1rs|>length() == 7

    # t1 = "off"
    # r1 = {{-50,50}, {-50,50}, {-50,50}}
    # t2 = "on"
    # r2 = {{-60,70}, {-20,20}, {-30,30}}
    # {{t1, t1rs}, {t2, r2}} = Day.handle_ranges({t1,r1},{t2,r2})
    # assert t1rs|>length() == 8

    # t1 = "off"
    # r1 = {{-50,50}, {-50,50}, {-50,50}}
    # t2 = "on"
    # r2 = {{60,90}, {-20,20}, {-30,30}}
    # {{t1, t1rs}, {t2, r2}} = Day.handle_ranges({t1,r1},{t2,r2})
    # assert t1rs|>length() == 17
  end

  test "region" do
    old = %{off: [
      {{-50,50},{-50,50},{-50,50}}
    ], on: []}
    new = {:on, {{-10,10},{-10,10},{-10,10}}}
    old_region=old|>Map.get(:off)|>hd()
    new_region=new|>Map.get(:on)|>hd()
    assert Day.include?(old_region, new_region)
    # next = Day.cal_region(old, new)
    # assert next == 
  end
end
