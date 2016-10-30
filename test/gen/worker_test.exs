defmodule EveryColor.GeneratorWorkerTest do
  use ExUnit.Case

  alias EveryColor.GeneratorWorker
  alias EveryColor.Range

  @test_range 1..(3*Range.caching_step)

  setup do
    {:ok,pid} = GeneratorWorker.start_link(@test_range)
    [worker: pid]
  end

  test "gets a first color from range", %{worker: pid} do
    first.._ = @test_range
    assert first == GeneratorWorker.color(pid)
  end

  test "removes color from cache", %{worker: pid} do
    GeneratorWorker.color(pid)
    %GeneratorWorker.RangeSet{cache: cache} = :sys.get_state pid
    assert length(cache) == Range.caching_step-1
  end

  test "after cachce depletion gets more colors", %{worker: pid} do
    color_in_new_cache = 0..(Range.caching_step)
    |> Enum.map(fn elem ->
      GeneratorWorker.color(pid)
    end)
    |> List.last

    assert color_in_new_cache == Range.caching_step + 1

  end
end
