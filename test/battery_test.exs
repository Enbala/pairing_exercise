defmodule Enbala.BatteryTest do
  use ExUnit.Case
  alias Enbala.Battery
  doctest Battery

  test "without current_power specified, defaults to 0" do
    battery = %Battery{id: "battery_1"}

    assert battery.current_power == 0
  end

  @tag :skip
  test ".new takes a map of parameters and builds a struct" do
    battery_params = %{id: "battery_1"}

    assert {:ok, %Battery{}} = Battery.new(battery_params)
  end

  @tag :skip
  test ".new does basic validations" do
    # TODO: What should we do here?
    assert {:error, _} = Battery.new(%{id: nil})

    # TODO: Should we enforce current_power <= rated_power?
    assert {:error, _} = Battery.new(%{id: "b1", current_power: 999, rated_power: 10})

    # TODO: Other validations?
  end

  @tag :skip
  test ".update_current_power/2" do
    {:ok, battery} = Battery.new(%{id: "b1", current_power: 100, rated_power: 1_000})
    updated_battery = Battery.set_current_power("b1", 50)

    assert updated_battery.current_power == 50
  end
end
