defmodule NervesMetalDetectorWeb.PageController do
  use NervesMetalDetectorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
