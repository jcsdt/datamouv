defmodule Server.Resource do
  use Ecto.Schema

  schema "resources" do
    field(:resource_id, :string)
    field(:title, :string)
    field(:latest, :string)
  end

  def new(%{id: id, title: title, latest: latest}) do
    %Server.Resource{resource_id: id, title: title, latest: latest}
  end

  def changeset(resource, params \\ %{}) do
    resource
    |> Ecto.Changeset.cast(params, [:resource_id, :title, :latest])
    |> Ecto.Changeset.validate_required([:resource_id, :title, :latest])
  end
end
