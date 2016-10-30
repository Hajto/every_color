defmodule EveryColor.DistributorTest do
  use ExUnit.Case

  alias EveryColor.Distributor

  test "Counter updates" do
    Distributor.random_color
    assert Distributor.get_counter > 0
  end

end
