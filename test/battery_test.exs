defmodule Enbala.BatteryTest do
  use ExUnit.Case
  alias Enbala.Battery
  doctest Battery

  test "without current_power specified, defaults to 0" do
    battery = %Battery{id: "battery_1"}

    assert battery.current_power == 0
  end

  @tag :skip
  test ".create takes a map of parameters, builds a struct and persists" do
    battery_params = %{id: "battery_1"}

    assert {:ok, %Battery{}} = Battery.create(battery_params)
  end

  @tag :skip
  test ".get with a previously created id retrieves the struct" do
    id = "battery_1"
    Battery.create(%{id: id})

    assert %Battery{id: ^id} = Battery.get(id)
  end

  @tag :skip
  test ".get with an id that hasn't been created" do
    assert nil == Battery.get("unknown_id")
  end

  @tag :skip
  test ".all returns battery structs that have been created" do
    id = "battery_1"
    Battery.create(%{id: id})

    assert [%Battery{id: ^id}] = Battery.all()
  end

  @tag :skip
  test ".set_current_power/2" do
    id = "battery_1"
    Battery.create(%{id: id})
    Battery.set_current_power(id, 5)

    assert %Battery{current_power: 5} = Battery.get(id)
  end
end
