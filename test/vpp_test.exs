defmodule Enbala.VppTest do
  use ExUnit.Case
  alias Enbala.Battery
  alias Enbala.Vpp
  doctest Vpp

  @tag :skip
  test ".current_power returns the sum of all asset's current_power" do
    first_battery = "battery_1"
    Battery.new(%{id: first_battery, current_power: 8})
    second_battery = "battery_2"
    Battery.new(%{id: second_battery, current_power: 3})

    Vpp.add_asset(first_battery)
    Vpp.add_asset(second_battery)

    assert Vpp.current_power() == 11
  end

  @tag :skip
  test ".export updates assets setpoint" do
    id = "battery_1"
    Battery.new(%{id: id})
    Vpp.add_asset(id)

    assert Vpp.current_power() == 0

    Vpp.export(5)

    assert %Battery{current_power: 5} = Battery.get(id)
    assert Vpp.current_power() == 5
  end

  @tag :skip
  test ".export updates assets setpoint respecting rated_power" do
    id = "battery_1"
    Battery.new(%{id: id})
    Vpp.add_asset(id)

    Vpp.export(20)

    assert %Battery{current_power: 10} = Battery.get(id)
    assert Vpp.current_power() == 10
  end

  @tag :skip
  test ".export with multiple batteries disperses load across batteries" do
    first_battery = "battery_1"
    Battery.new(%{id: first_battery})
    second_battery = "battery_2"
    Battery.new(%{id: second_battery})

    Vpp.add_asset(first_battery)
    Vpp.add_asset(second_battery)

    Vpp.export(10)

    assert %Battery{current_power: 5} = Battery.get(first_battery)
    assert %Battery{current_power: 5} = Battery.get(second_battery)

    assert Vpp.current_power() == 10
  end

  @tag :skip
  test ".export delivers additional power to grid" do
    first_battery = "battery_1"
    Battery.new(%{id: first_battery, current_power: 8})
    second_battery = "battery_2"
    Battery.new(%{id: second_battery, current_power: 3})

    Vpp.add_asset(first_battery)
    Vpp.add_asset(second_battery)

    Vpp.export(2)

    assert %Battery{current_power: 9} = Battery.get(first_battery)
    assert %Battery{current_power: 4} = Battery.get(second_battery)
  end
end
