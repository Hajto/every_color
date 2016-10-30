defmodule EveryColor.GeneratorSupervisor do
  use Supervisor

  @name :color_generator

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def spawn_generator(range) do
    Supervisor.start_child(@name, [range])
  end

  def init(:ok) do
    children = [
      worker(EveryColor.GeneratorWorker, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

end
