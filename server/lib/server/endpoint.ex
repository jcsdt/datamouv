defmodule Server.Endpoint do
  use Plug.Builder

  plug(Corsica, origins: "*")
  plug(Server.Router, port: 4000)
end
