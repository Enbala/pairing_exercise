defmodule Enbala.VppTest do
  use ExUnit.Case
  alias Enbala.Battery
  alias Enbala.Vpp
  doctest Vpp

  @tag :skip
  test ".current_power returns the sum of all asset's current_power" do
    {:ok, first_battery} = Battery.new(%{id: "battery_1", current_power: 8})
    {:ok, second_battery} = Battery.new(%{id: "battery_2", current_power: 3})

    Vpp.add_asset(first_battery)
    Vpp.add_asset(second_battery)

    assert Vpp.current_power() == 11
  end

  @tag :skip
  test ".export updates asset's setpoint" do
    {:ok, battery} = Battery.new(%{id: "battery_1"})
    Vpp.add_asset(battery)

    assert Vpp.current_power() == 0

    Vpp.export(5)

    [%Battery{current_power: updated_battery_power}] = Vpp.batteries()
    assert updated_battery_power == 5
    assert Vpp.current_power() == 5
  end

  @tag :skip
  test ".export updates asset's setpoint respecting rated_power" do
    {:ok, battery} = Battery.new(%{id: "battery_1"})
    Vpp.add_asset(battery)

    Vpp.export(20)

    [%Battery{current_power: updated_battery_power}] = Vpp.batteries()
    assert updated_battery_power == 10
    assert Vpp.current_power() == 10
  end

  @tag :skip
  test ".export with multiple batteries disperses load across batteries" do
    {:ok, first_battery} = Battery.new(%{id: "battery_1"})
    {:ok, second_battery} = Battery.new(%{id: "battery_2"})

    Vpp.add_asset(first_battery)
    Vpp.add_asset(second_battery)

    Vpp.export(10)

    [updated_battery_1, updated_battery_2] = Vpp.batteries()
    assert updated_battery_1.current_power == 5
    assert updated_battery_2.current_power == 5

    assert Vpp.current_power() == 10
  end

  @tag :skip
  test ".export delivers additional power to grid" do
    {:ok, first_battery} = Battery.new(%{id: "battery_1", current_power: 8})
    {:ok, second_battery} = Battery.new(%{id: "battery_2", current_power: 3})

    Vpp.add_asset(first_battery)
    Vpp.add_asset(second_battery)

    Vpp.export(2)

    power_values =
      Vpp.batteries()
      |> Enum.map(fn %Battery{current_power: p} -> p end)
      |> Enum.sort()

    assert power_values == [4, 9]
  end
end
