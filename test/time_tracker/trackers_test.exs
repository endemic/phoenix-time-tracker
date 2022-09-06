defmodule TimeTracker.TrackersTest do
  use TimeTracker.DataCase

  alias TimeTracker.Trackers

  describe "timers" do
    alias TimeTracker.Trackers.Timer

    import TimeTracker.TrackersFixtures

    @invalid_attrs %{started_at: nil, total_minutes: nil, workday: nil}

    test "list_timers/0 returns all timers" do
      timer = timer_fixture()
      assert Trackers.list_timers() == [timer]
    end

    test "get_timer!/1 returns the timer with given id" do
      timer = timer_fixture()
      assert Trackers.get_timer!(timer.id) == timer
    end

    test "create_timer/1 with valid data creates a timer" do
      valid_attrs = %{started_at: ~N[2022-09-05 00:11:00], total_minutes: 42, workday: ~D[2022-09-05]}

      assert {:ok, %Timer{} = timer} = Trackers.create_timer(valid_attrs)
      assert timer.started_at == ~N[2022-09-05 00:11:00]
      assert timer.total_minutes == 42
      assert timer.workday == ~D[2022-09-05]
    end

    test "create_timer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trackers.create_timer(@invalid_attrs)
    end

    test "update_timer/2 with valid data updates the timer" do
      timer = timer_fixture()
      update_attrs = %{started_at: ~N[2022-09-06 00:11:00], total_minutes: 43, workday: ~D[2022-09-06]}

      assert {:ok, %Timer{} = timer} = Trackers.update_timer(timer, update_attrs)
      assert timer.started_at == ~N[2022-09-06 00:11:00]
      assert timer.total_minutes == 43
      assert timer.workday == ~D[2022-09-06]
    end

    test "update_timer/2 with invalid data returns error changeset" do
      timer = timer_fixture()
      assert {:error, %Ecto.Changeset{}} = Trackers.update_timer(timer, @invalid_attrs)
      assert timer == Trackers.get_timer!(timer.id)
    end

    test "delete_timer/1 deletes the timer" do
      timer = timer_fixture()
      assert {:ok, %Timer{}} = Trackers.delete_timer(timer)
      assert_raise Ecto.NoResultsError, fn -> Trackers.get_timer!(timer.id) end
    end

    test "change_timer/1 returns a timer changeset" do
      timer = timer_fixture()
      assert %Ecto.Changeset{} = Trackers.change_timer(timer)
    end
  end
end
