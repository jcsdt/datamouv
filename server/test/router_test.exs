defmodule RouterTest do
  use ExUnit.Case
  use Plug.Test
  doctest Server.Router

  @opts Server.Router.init([])

  test "not found" do
    conn = conn(:get, "/something")

    conn = Server.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
  end
end
