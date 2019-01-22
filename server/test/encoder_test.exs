defmodule EncoderTest do
  use ExUnit.Case
  doctest Server.Encoder

  import Server.Encoder, only: [encode: 1, transcode_single_resource: 1]

  test "transcode single resource" do
    resource = Server.Resource.new(%{id: "123", title: "Title", latest: "http://url"})
    assert transcode_single_resource(resource) == %{id: "123", title: "Title", latest: "http://url"}
  end

  test "encode resources" do
    resources = [
      %Server.Resource{resource_id: "123", title: "Title", latest: "http://url"},
      %Server.Resource{resource_id: "456", title: "Title 2", latest: "http://url"}
    ]
    assert encode(resources) == "[{\"title\":\"Title\",\"latest\":\"http://url\",\"id\":\"123\"},{\"title\":\"Title 2\",\"latest\":\"http://url\",\"id\":\"456\"}]"
  end
end
