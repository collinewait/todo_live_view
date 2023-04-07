defmodule TodoLiveViewWeb.PageController do
  use TodoLiveViewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
