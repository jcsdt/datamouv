defmodule Scrapper.Repo.Migrations.CreateResources do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :resource_id, :string
      add :title, :string
      add :latest, :string
    end
  end
end
