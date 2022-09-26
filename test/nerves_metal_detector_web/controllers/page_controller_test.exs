defmodule NervesMetalDetectorWeb.PageControllerTest do
  use NervesMetalDetectorWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Nerves Metal Detector"
  end
end
