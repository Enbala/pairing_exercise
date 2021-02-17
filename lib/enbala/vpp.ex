defmodule Enbala.Vpp do
  @moduledoc """
  A Virtual Power Plant or VPP is a collection of controlable assets, batteries in our
  case, that we can use to bring additional stability to the grid.

  Our Vpp module is simpler than what would be used in the real-world, it can only do
  two things. Firstly, It can calculate the total amount of power all of our batteries
  are contributing to the grid. It can also be asked to export an additional amount of
  power to the grid.
  """

  def current_power do
    0
  end

  def export(_power) do
    :ok
  end
end