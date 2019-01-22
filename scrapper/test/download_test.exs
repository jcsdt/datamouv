defmodule DownloadTest do
  use ExUnit.Case
  doctest Scrapper.Download

  import Scrapper.Download, only: [path: 2]

  test "file path" do
    assert path(
             "./data",
             Scrapper.Resource.new(%{id: "123", title: "Title", latest: "http://url"})
           ) == "./data/123"
  end
end
