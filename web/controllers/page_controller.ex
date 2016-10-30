defmodule EveryColor.PageController do
  use EveryColor.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
