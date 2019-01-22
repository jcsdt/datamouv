defmodule Scrapper.Application do
  @moduledoc false

  use Application

  def start(_type, args) do
    args
    |> Scrapper.CLI.parse_argv()
    |> process
  end

  @start_page Application.get_env(:scrapper, :start_page)
  @nb_pages Application.get_env(:scrapper, :nb_pages)
  @data_folder Application.get_env(:scrapper, :data_folder)

  defp process(:help) do
    IO.puts("""
        Usage: scrapper < start page | default: #{@start_page} > < number of pages to scrap | default: #{
      @nb_pages
    } > < data folder | default: #{@data_folder} >
    """)

    System.halt(0)
  end

  defp process([start_page, nb_pages, data_folder]) do
    children = [
      Scrapper.Repo,
      {Scrapper.UrlGenerator, {start_page, nb_pages}},
      {Scrapper.Store, data_folder},
      {Task.Supervisor, name: Scrapper.TaskSupervisor},
      {Task, fn -> Scrapper.Store.scrap_pages() end}
    ]

    opts = [strategy: :one_for_all, name: Scrapper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
