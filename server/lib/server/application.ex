defmodule Server.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Server.Repo, []},
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Server.Endpoint
      )
    ]

    opts = [strategy: :one_for_one, name: Server.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
