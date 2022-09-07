defmodule TimeTracker.Accounts.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias TimeTracker.Accounts.Client

  schema "projects" do
    field :name, :string

    belongs_to :client, Client

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:client_id, :name])
    |> validate_required([:client_id, :name])
  end
end
