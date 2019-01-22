defmodule RouterTest do
  use ExUnit.Case
  use Plug.Test
  doctest Server.Router

  @opts Server.Router.init([])

  test "/resources endpoint" do
    conn = conn(:get, "/resources")

    conn = Server.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "/resource/id endpoint" do
    conn = conn(:get, "/resource/123")

    conn = Server.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
  end
end
