defmodule EveryColor.Distributor do
  use GenServer

  alias EveryColor.GeneratorSupervisor

  @used_colors EveryColor.Distributor.AllUSedColors

  #It will never reach last position
  @max 256*256*256
  @ranges 500
  @per_range @max/@ranges

  defmodule State do
    defstruct queue: []
  end

  ## Init

  def start_link do
    Agent.start_link(fn -> 0 end, name: @used_colors)
    GenServer.start_link(__MODULE__, distribute_work, name: __MODULE__)
  end

  def init(processes) do
    #IO.inspect "Starting distributor"
    {:ok, processes }
  end

  ## Client Api

  def random_color do
    bump_counter
    handler_pid = GenServer.call(__MODULE__, :get_color)
    EveryColor.GeneratorWorker.color(handler_pid)
  end

  def out_of_colors(pid) do
    GenServer.cast(__MODULE__, {:remove_server, pid})
  end

  ## Server Api

  def handle_call(:get_color, _caller, state) do
    {:reply, Enum.random(state), state}
  end

  def handle_cast({:remove_server, pid}, state) do
    filtered = Enum.filter(&(&1 != pid), state)
    {:noreply, filtered}
  end

  ## Helpers

  def distribute_work do
    calc_batch
    |> Enum.map(fn range ->
      {:ok, pid} = GeneratorSupervisor.spawn_generator(range)
      pid
    end)
  end

  def calc_batch do
    0..(@ranges-1)
    |> Enum.map(fn elem ->
      start = elem * @per_range
      ending = (elem+1)*@per_range
      trunc(start)..(trunc(ending)-1)
    end)
  end

  def bump_counter do
    Agent.update(@used_colors, &(&1+1))
  end

  def get_counter do
    Agent.get(@used_colors, &(&1))
  end

end
