defmodule Scrapper.API do
  @user_agent [{"User-agent", "Scrapper"}]
  @data_gouv_url Application.get_env(:scrapper, :data_gouv_url)

  def fetch(page_number) do
    data_gouv_url(page_number)
    |> HTTPoison.get(@user_agent)
    |> handle_response
    |> decode_response
  end

  defp data_gouv_url(page_number) do
    "#{@data_gouv_url}?page=#{page_number}&page_size=1"
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

  defp decode_response({:error, error}) do
    IO.puts("""
      Error fetching data #{error}
    """)

    System.halt(2)
  end
end
