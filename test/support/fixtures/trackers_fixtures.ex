defmodule TimeTracker.TrackersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeTracker.Trackers` context.
  """

  @doc """
  Generate a timer.
  """
  def timer_fixture(attrs \\ %{}) do
    {:ok, timer} =
      attrs
      |> Enum.into(%{
        started_at: ~N[2022-09-05 00:11:00],
        total_minutes: 42,
        workday: ~D[2022-09-05]
      })
      |> TimeTracker.Trackers.create_timer()

    timer
  end
end
