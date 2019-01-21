defmodule Scrapper.UrlGenerator do
  use Agent

  @me __MODULE__

  @data_gouv_url Application.get_env(:scrapper, :data_gouv_url)

  # API
  def start_link({start_page, page_count}) do
    GenServer.start_link(@me, {start_page, page_count}, name: @me)
  end

  def next_page_url() do
    GenServer.call(@me, :next_page)
  end

  # Server
  def init({start_page, page_count}) do
    {:ok, {start_page, start_page + page_count}}
  end

  def handle_call(:next_page, _from, {end_page, end_page}) do
    {:reply, :done, {end_page, end_page}}
  end

  def handle_call(:next_page, _from, {start_page, end_page}) do
    {:reply, data_gouv_url(start_page), {start_page + 1, end_page}}
  end

  defp data_gouv_url(page_number) do
    "#{@data_gouv_url}?page=#{page_number}&page_size=1"
  end
end
