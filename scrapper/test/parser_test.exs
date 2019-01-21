defmodule ParserTest do
  use ExUnit.Case
  doctest Scrapper

  import Scrapper.Parser, only: [parse: 1]

  test "parse valid data with resouces" do
    assert parse(%{
             "data" => [
               %{
                 "resources" => [
                   %{
                     "id" => "1",
                     "title" => "Nord Pas-de-Calais ( GeoJSON )",
                     "latest" => "https://url"
                   },
                   %{
                     "id" => "2",
                     "title" => "Code électoral",
                     "latest" => "https://url"
                   }
                 ]
               }
             ]
           }) == [
             %{id: "1", title: "Nord Pas-de-Calais ( GeoJSON )", latest: "https://url"},
             %{id: "2", title: "Code électoral", latest: "https://url"}
           ]
  end

  test "parse data without resources" do
    catch_error(
      parse(%{
        "data" => [
          %{}
        ]
      })
    )
  end
end
