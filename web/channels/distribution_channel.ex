defmodule EveryColor.DistributionChannel do
  use Phoenix.Channel

  def join("colors:*", _message, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push socket, "color_generated", %{color: EveryColor.Distributor.random_color}
    {:noreply, socket}
  end

  def handle_in("get", _payload, socket) do
    {:reply, {:ok, %{color: EveryColor.Distributor.random_color}}, socket}
  end

end
