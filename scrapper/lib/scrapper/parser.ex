defmodule Scrapper.Parser do
  @moduledoc """
  Parse a JSON document into Resources
  """

  def parse(%{"data" => data}) do
    data
    |> Enum.flat_map(&parse_resources/1)
  end

  defp parse_resources(%{"resources" => resources}) do
    resources
    |> Enum.map(&parse_single_resource/1)
  end

  defp parse_single_resource(%{"id" => id, "title" => title, "latest" => latest}) do
    Scrapper.Resource.new(%{id: id, title: title, latest: latest})
  end
end
