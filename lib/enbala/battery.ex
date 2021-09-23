defmodule Enbala.Battery do
  @moduledoc """
  When Enbala is managing the health of the power grid, a battery connected to
  the grid (via a smart inverter) is a really helpful tool to be able to leverage.
  They're capable of exporting power to the grid if there isn't enough generation,
  absorb power if there's too much generation, and even regulate frequency (and
  that's not all!).

  Our battery module is a little bit simpler than real-world batteries. We're only
  interested in keeping track of three things for our batteries. A unique `id`
  that we can use to send it messages, the amount of power the battery is currently
  contributing to the grid (current_power), and what the maximum amount of power the
  battery could contribute to the grid (rated_power).
  """
  defstruct [:id, :current_power, rated_power: 10]

  def new(_params) do
    {:error, :not_implemented}
  end

  def update_current_power(_battery_struct, _power_value) do
    {:error, :not_implemented}
  end
end
