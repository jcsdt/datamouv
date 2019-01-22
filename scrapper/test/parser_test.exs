defmodule ParserTest do
  use ExUnit.Case
  doctest Scrapper

  import Scrapper.Parser, only: [parse: 1]

  test "parse valid data with resouces" do
    resources =
      parse(%{
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
      })

    assert resources == [
             %Scrapper.Resource{
               resource_id: "1",
               title: "Nord Pas-de-Calais ( GeoJSON )",
               latest: "https://url"
             },
             %Scrapper.Resource{resource_id: "2", title: "Code électoral", latest: "https://url"}
           ]

    assert Enum.map(resources, &Scrapper.Resource.changeset(&1).valid?) == [true, true]
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
