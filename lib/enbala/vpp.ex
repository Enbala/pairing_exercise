defmodule Enbala.Vpp do
  @moduledoc """
  A Virtual Power Plant or VPP is a collection of controllable assets, batteries in our
  case, that we can use to bring additional stability to the grid.

  Our Vpp module is simpler than what would be used in the real-world, it can only do
  two things. Firstly, it can calculate the total amount of power all of our batteries
  are contributing to the grid. Secondly, it can be asked to export an additional amount
  of power to the grid.
  """

  def add_asset(battery) do
    :ok
  end

  def current_power do
    0
  end

  def batteries do
    []
  end

  def export(_power) do
    :ok
  end
end
