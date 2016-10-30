defmodule EveryColor.ColorSocket do
  use Phoenix.Socket

  transport :websocket, Phoenix.Transports.WebSocket

  ## Channels

  channel "colors:*", EveryColor.DistributionChannel

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil

end
