defmodule Scrapper.Store do
  use Agent

  @me __MODULE__

  defmodule State do
    defstruct(pages_to_fetch: 0, resources_to_download: 0, data_folder: "")
  end

  def start_link(data_folder) do
    Agent.start_link(fn -> %State{data_folder: data_folder} end, name: @me)
  end

  def fetch_url(url) do
    Agent.update(@me, fn state = %{pages_to_fetch: n} -> %{state | pages_to_fetch: n + 1} end)

    Task.Supervisor.start_child(Scrapper.TaskSupervisor, Scrapper.FetchPage, :fetch, [url])
  end

  def report_fetch_url_done() do
    {pages, downloads} =
      Agent.get_and_update(@me, fn state = %{pages_to_fetch: p, resources_to_download: r} ->
        {{p - 1, r}, %{state | pages_to_fetch: p - 1}}
      end)

    are_we_done(pages, downloads)
  end

  def add_resource(resource) do
    folder =
      Agent.get_and_update(@me, fn state = %{data_folder: folder, resources_to_download: n} ->
        {folder, %{state | resources_to_download: n + 1}}
      end)

    Task.Supervisor.start_child(Scrapper.TaskSupervisor, Scrapper.Download, :download, [
      resource,
      folder
    ])
  end

  def report_download_done() do
    {pages, downloads} =
      Agent.get_and_update(@me, fn state = %{pages_to_fetch: p, resources_to_download: r} ->
        {{p, r - 1}, %{state | resources_to_download: r - 1}}
      end)

    are_we_done(pages, downloads)
  end

  def are_we_done(0, 0) do
    IO.puts("We are all done, bye, bye...")
    System.halt(0)
  end

  def are_we_done(_, _) do
  end
end
