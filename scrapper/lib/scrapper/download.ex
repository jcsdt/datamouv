defmodule Scrapper.Download do
  use Task, restart: :transient

  def start_link(resource, folder) do
    Task.start_link(__MODULE__, :download, [resource, folder])
  end

  def download(resource, folder) do
    IO.puts("Downloading #{resource.latest}")
    :ok = File.mkdir_p(folder)

    {:ok, response} =
      HTTPoison.get(resource.latest, [], follow_redirect: true, recv_timeout: 60_000)

    {:ok, file} = File.open(path(folder, resource), [:write])
    :ok = IO.binwrite(file, response.body)
    :ok = File.close(file)

    {:ok, _} = Scrapper.Repo.insert(resource)

    Scrapper.Store.report_download_done()
  end

  def path(folder, resource) do
    "#{folder}/#{resource.resource_id}"
  end
end
