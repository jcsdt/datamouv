defmodule Server.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/resources" do
    conn
    |> put_resp_header("content-type", "application/json")
    |> resp(200, 
      Poison.encode!([
        %{title: "Hello", latest: "https://url"},
        %{title: "World", latest: "https://url"}
      ])
      )
      |> send_resp
  end

  get "/resource/:id" do
    conn
    |> put_resp_header("content-type", "application/json")
    |> resp(200, Poison.encode!(%{id: "#{id}"}))
    |> send_resp
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
