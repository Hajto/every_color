defmodule EveryColor.GeneratorWorker do
  use GenServer

  require Logger

  defmodule RangeSet do
    defstruct range: nil, cache: []
  end

  ## Init

  def start_link(range) do
    GenServer.start_link(__MODULE__, cache_pack(range) )
  end

  def init(range) do
    Logger.debug inspect(range)
    {:ok, range}
  end

  ## Client Api

  def color(process), do: GenServer.call(process,:get_color)

  ## Server Api

  def handle_call(:get_color, _caller, state) do
    #IO.inspect "Cache length #{length(state.cache)}"
    case state.cache do
      [x | tail] ->
        {:reply, x, %RangeSet{state | cache: tail} }
      _ ->
        new_state = cache_pack(state.range)
        [head | tail] = new_state.cache
        {:reply, head, %RangeSet{new_state | cache: tail} }
    end
  end

  ## Helpers

  defp cache_pack(range) do
    { cache, range } = EveryColor.Range.cache(range)
    %RangeSet{ cache: cache, range: range}
  end

end
