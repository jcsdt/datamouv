defmodule Scrapper.CLI do
  @moduledoc """
  Module to parse and check the arguments passed on the commandline.
  """
  def parse_argv(argv) do
    OptionParser.parse(argv,
      switches: [help: :boolean],
      aliases: [h: :help]
    )
    |> elem(1)
    |> process_args
  end

  defp process_args([start, nb_pages, data_folder]) do
    check_args([Integer.parse(start), Integer.parse(nb_pages), data_folder])
  end

  @start_page Application.get_env(:scrapper, :start_page)
  @nb_pages Application.get_env(:scrapper, :nb_pages)
  @data_folder Application.get_env(:scrapper, :data_folder)

  defp process_args([]) do
    [@start_page, @nb_pages, @data_folder]
  end

  defp process_args(_) do
    :help
  end

  defp check_args([{start_page, _}, {nb_pages, _}, data_folder])
       when start_page > 0 and nb_pages > 0 do
    [start_page, nb_pages, data_folder]
  end

  defp check_args(_) do
    :help
  end
end
