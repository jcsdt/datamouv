defmodule Scrapper.FetchPage do
  use Task

  @moduledoc """
  Fetch a page and emit tasks to download all resources on it
  """

  @me __MODULE__
  @user_agent [{"User-agent", "Scrapper"}]

  def start_link(url) do
    Task.start_link(@me, :fetch, [url])
  end

  def fetch(url) do
    IO.puts("Fetching #{url}")

    url
    |> HTTPoison.get(@user_agent)
    |> handle_response
    |> decode_response
    |> Scrapper.Parser.parse()
    |> Enum.map(&Scrapper.Store.add_resource/1)

    Scrapper.Store.report_fetch_url_done()
  end

  defp handle_response({_, %{status_code: status, body: body}}) do
    {
      status |> check_status_code(),
      body
    }
  end

  defp check_status_code(200), do: :ok
  defp check_status_code(_), do: :error

  defp parse(body) do
    Poison.Parser.parse!(body)
  end

  defp decode_response({:ok, body}) do
    parse(body)
  end
end
