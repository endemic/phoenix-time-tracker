defmodule TimeTracker.Trackers.Timer do
  use Ecto.Schema
  import Ecto.Changeset

  alias TimeTracker.Accounts.Project
  alias TimeTracker.Accounts.User

  schema "timers" do
    field :started_at, :naive_datetime
    field :total_minutes, :integer
    field :workday, :date

    belongs_to :project, Project
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(attrs, [:started_at, :total_minutes, :workday])
    |> validate_required([:started_at, :total_minutes, :workday])
  end
end
