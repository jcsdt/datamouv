defmodule Scrapper.Parser do
  def parse(%{"data" => data}) do
    data
    |> Enum.flat_map(&parse_resources/1)
  end

  defp parse_resources(%{"resources" => resources}) do
    resources
    |> Enum.map(&parse_single_resource/1)
  end

  defp parse_single_resource(%{"id" => id, "title" => title, "latest" => latest}) do
    [id: id, title: title, latest: latest]
  end
end
