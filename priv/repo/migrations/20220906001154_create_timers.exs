defmodule TimeTracker.Repo.Migrations.CreateTimers do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :started_at, :naive_datetime
      add :total_minutes, :integer
      add :workday, :date
      add :project_id, references(:projects, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:timers, [:project_id])
    create index(:timers, [:user_id])
  end
end
