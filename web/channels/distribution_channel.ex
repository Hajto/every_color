defmodule EveryColor.DistributionChannel do
  use Phoenix.Channel

  alias EveryColor.Distributor

  def init do
    IO.inspect "DZIALA KURWA"
  end

  def join("colors:"<>_ , _message, socket) do
    send(self, :after_join)
    {:ok, %{color: Distributor.random_color, counter: Distributor.get_counter} ,socket}
  end

  def handle_info(:after_join, socket) do
    broadcast_counter socket
    {:noreply, socket}
  end

  def handle_in("get", _payload, socket) do
    color = Distributor.random_color
    broadcast_counter socket
    {:reply, {:ok, %{color: color}}, socket}
  end

  def broadcast_counter(socket) do
    broadcast socket, "counter_bump", %{counter: Distributor.get_counter}
  end

end
