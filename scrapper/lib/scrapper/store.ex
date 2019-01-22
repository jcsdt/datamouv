defmodule Scrapper.Store do
  use Agent

  @me __MODULE__

  defmodule State do
    defstruct(pending_tasks: 0, all_pages_generated: false, data_folder: "")
  end

  def start_link(data_folder) do
    Agent.start_link(fn -> %State{data_folder: data_folder} end, name: @me)
  end

  def scrap_pages() do
    case Scrapper.UrlGenerator.next_page_url() do
      :done ->
    	Agent.update(@me, fn state -> %{state | all_pages_generated: true} end)

      url ->
        Scrapper.Store.fetch_url(url)
        Scrapper.Store.scrap_pages()
    end
  end

  def fetch_url(url) do
    add_pending_task()

    Task.Supervisor.start_child(Scrapper.TaskSupervisor, Scrapper.FetchPage, :fetch, [url])
  end

  def report_fetch_url_done() do
    report_task_completed()
  end

  def add_resource(resource) do
    add_pending_task()
    %{data_folder: folder} = Agent.get(@me, &(&1))

    Task.Supervisor.start_child(Scrapper.TaskSupervisor, Scrapper.Download, :download, [
      resource,
      folder
    ])
  end

  def report_download_done() do
    report_task_completed()
  end

  defp add_pending_task() do
    Agent.update(@me, fn state = %{pending_tasks: n} -> %{state | pending_tasks: n + 1} end)
  end

  defp report_task_completed() do
    state =
      Agent.get_and_update(@me, fn state = %{pending_tasks: p, all_pages_generated: b} ->
        {{p, b}, %{state | pending_tasks: p - 1}}
      end)

    IO.inspect(state)
    are_we_done(state)
  end

  def are_we_done({0, true}) do
    IO.puts("We are all done, bye, bye...")
    System.halt(0)
  end

  def are_we_done(_) do
  end
end
