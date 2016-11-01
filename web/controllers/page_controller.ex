defmodule EveryColor.PageController do
  use EveryColor.Web, :controller

  def index(conn, _params) do
    html(conn, File.read!("priv/static/index.html"))
  end
end
