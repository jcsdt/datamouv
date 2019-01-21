defmodule UrlGeneratorTest do
  use ExUnit.Case
  doctest Scrapper

  test "all urls are generated" do
    start_supervised!({Scrapper.UrlGenerator, {0, 2}})

    assert Scrapper.UrlGenerator.next_page_url() ==
             "https://www.data.gouv.fr/api/1/datasets/?page=0&page_size=1"

    assert Scrapper.UrlGenerator.next_page_url() ==
             "https://www.data.gouv.fr/api/1/datasets/?page=1&page_size=1"

    assert Scrapper.UrlGenerator.next_page_url() == :done
  end
end
