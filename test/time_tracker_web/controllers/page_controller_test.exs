defmodule TimeTrackerWeb.PageControllerTest do
  use TimeTrackerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Track ur time here!"
  end
end
