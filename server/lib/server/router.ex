defmodule Server.Router do
  use Plug.Router

  @moduledoc """
  Serves the API endpoints
  """

  plug(:match)
  plug(:dispatch)

  get "/api/resources" do
    conn
    |> resp(200, list_resources())
    |> put_resp_content_type("application/json")
    |> send_resp
  end

  def list_resources() do
    Server.Resource
    |> Server.Repo.all()
    |> Server.Encoder.encode()
  end

  get "/api/resource/:id" do
    path = "./data/#{id}"

    if File.exists?(path) do
      conn
      |> send_file(200, path)
    else
      conn
      |> send_resp(404, "Not found")
    end
  end

  options _ do
    conn
    |> put_resp_header("access-control-allow-origin", "*")
    |> resp(200, "")
    |> send_resp
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
