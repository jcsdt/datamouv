defmodule Scrapper.Downloader do
  def download(resource, folder) do
    IO.puts "Downloading #{resource.latest}"
    :ok = File.mkdir_p(folder)
    {:ok, response} = HTTPoison.get(resource.latest, [], [follow_redirect: true, recv_timeout: 60_000])
    {:ok, file} = File.open("#{folder}/#{resource.id}", [:write])
    :ok = IO.binwrite(file, response.body)
    :ok = File.close(file)
  end
end
