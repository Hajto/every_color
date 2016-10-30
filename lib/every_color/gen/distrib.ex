defmodule EveryColor.Distributor do
  use GenServer

  alias EveryColor.GeneratorSupervisor

  @max 255*255*255
  @ranges 500
  @per_range @max/@ranges

  defmodule State do
    defstruct queue: []
  end

  ## Init

  def start_link do
    GenServer.start_link(__MODULE__, distribute_work, name: __MODULE__)
  end

  def init(processes) do
    #IO.inspect "Starting distributor"
    {:ok, :queue.from_list processes }
  end

  ## Client Api

  def random_color do
    handler_pid = GenServer.call(__MODULE__, :get_color)
    EveryColor.GeneratorWorker.color(handler_pid)
  end

  ## Server Api

  def handle_call(:get_color, _caller, state) do
    {{:value, pid}, new_queue} = :queue.out(state)
    {:reply, pid, :queue.in(pid, new_queue)}
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

end
