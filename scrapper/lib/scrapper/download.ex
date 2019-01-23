defmodule Scrapper.Download do
  use Task

  def start_link(resource, folder) do
    Task.start_link(__MODULE__, :download, [resource, folder])
  end

  def download(resource, folder) do
    IO.puts("Downloading #{resource.latest}")
    :ok = File.mkdir_p(folder)

    {:ok, response} =
      HTTPoison.get(resource.latest, [], follow_redirect: true, recv_timeout: 30_000)

    {:ok, file} = File.open(path(folder, resource), [:write])
    :ok = IO.binwrite(file, response.body)
    :ok = File.close(file)

    {:ok, _} = insert_if_absent(resource)

    Scrapper.Store.report_download_done()
  end

  defp insert_if_absent(resource) do
    Scrapper.Repo.transaction(fn ->
      existing_resource =
        Scrapper.Repo.get_by(Scrapper.Resource, resource_id: resource.resource_id)

      if existing_resource != nil do
        {:ok, existing_resource}
      else
        Scrapper.Repo.insert(resource)
      end
    end)
  end

  def path(folder, resource) do
    "#{folder}/#{resource.resource_id}"
  end
end
