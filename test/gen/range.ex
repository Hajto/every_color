defmodule EveryColor.RangeTest do
  use ExUnit.Case

  alias EveryColor.Range

  @valid_range 1..200
  @caching_step Range.caching_step

  test "If range is big enough subracts itself and fives cached array" do
    { list, range } = Range.cache(@valid_range)
    assert length(list) == @caching_step
    new_start.._new_end = range
    old_start.._old_end = @valid_range
    assert old_start + @caching_step == new_start
  end

end
