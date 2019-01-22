defmodule Server.Encoder do
  def encode(resources) do
    resources
    |> Enum.map(&transcode_single_resource/1)
    |> Poison.encode!
  end

  def transcode_single_resource(%Server.Resource{resource_id: id, title: title, latest: latest}) do
    %{id: id, title: title, latest: latest}
  end
end
