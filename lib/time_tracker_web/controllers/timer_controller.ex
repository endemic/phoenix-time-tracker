defmodule TimeTrackerWeb.TimerController do
  use TimeTrackerWeb, :controller

  alias TimeTracker.Trackers
  alias TimeTracker.Trackers.Timer
  alias TimeTracker.Repo

  def index(conn, _params) do
    logged_in_user_id = conn.assigns.current_user.id

    today = NaiveDateTime.local_now() |> NaiveDateTime.to_date()
    yesterday = today |> Date.add(-1)
    tomorrow = today |> Date.add(1)

    dates = %{today: today, tomorrow: tomorrow, yesterday: yesterday}

    timers = Trackers.list_timers_for_user(logged_in_user_id, today)
    render(conn, "index.html", timers: timers, dates: dates)
  end

  def by_date(conn, %{"date" => date}) do
    logged_in_user_id = conn.assigns.current_user.id

    {:ok, today} = Date.from_iso8601(date)
    yesterday = today |> Date.add(-1)
    tomorrow = today |> Date.add(1)

    dates = %{today: today, tomorrow: tomorrow, yesterday: yesterday}

    timers = Trackers.list_timers_for_user(logged_in_user_id, today)
    render(conn, "index.html", timers: timers, dates: dates)
  end

  def new(conn, _params) do
    # set by `TimeTrackerWeb.UserAuth.fetch_current_user` controller method
    IO.puts inspect conn.assigns.current_user

    projects = TimeTracker.Accounts.list_projects()

    changeset = Trackers.change_timer(%Timer{})
    render(conn, "new.html", changeset: changeset, projects: projects)
  end

  def create(conn, %{"timer" => timer_params}) do
    # attempt to fetch the user_id from the connection and slap it into timer params
    timer_params = Map.put(timer_params, "user_id", conn.assigns.current_user.id)

    case Trackers.create_timer(timer_params) do
      {:ok, timer} ->
        conn
        |> put_flash(:info, "Timer created successfully.")
        |> redirect(to: Routes.timer_path(conn, :show, timer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    timer = Trackers.get_timer!(id)
    render(conn, "show.html", timer: timer)
  end

  def start(conn, %{"id" => id}) do
    timer = Trackers.get_timer!(id)
    case Trackers.start_timer(timer) do
      {:ok, timer} ->
        conn
        |> put_flash(:info, "Timer started.")
        |> redirect(to: Routes.timer_path(conn, :index))

      {:error, %Ecto.Changeset{} = _changeset} ->
        IO.puts inspect _changeset
        conn
        |> put_flash(:info, "Error starting timer")
        |> redirect(to: Routes.timer_path(conn, :index))
    end
  end

  def stop(conn, %{"id" => id}) do
    timer = Trackers.get_timer!(id)
    case Trackers.stop_timer(timer) do
      {:ok, timer} ->
        conn
        |> put_flash(:info, "Timer stopped.")
        |> redirect(to: Routes.timer_path(conn, :index))

      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:info, "Error stopping timer")
        |> redirect(to: Routes.timer_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    timer = Trackers.get_timer!(id)
    changeset = Trackers.change_timer(timer)
    projects = TimeTracker.Accounts.list_projects()
    render(conn, "edit.html", timer: timer, changeset: changeset, projects: projects)
  end

  def update(conn, %{"id" => id, "timer" => timer_params}) do
    timer = Trackers.get_timer!(id)

    # attempt to fetch the user_id from the connection and slap it into timer params
    timer_params = Map.put(timer_params, "user_id", conn.assigns.current_user.id)

    IO.puts inspect timer_params

    case Trackers.update_timer(timer, timer_params) do
      {:ok, timer} ->
        conn
        |> put_flash(:info, "Timer updated successfully.")
        |> redirect(to: Routes.timer_path(conn, :show, timer))

      {:error, %Ecto.Changeset{} = changeset} ->
        projects = TimeTracker.Accounts.list_projects()
        render(conn, "edit.html", timer: timer, changeset: changeset, projects: projects)
    end
  end

  def delete(conn, %{"id" => id}) do
    timer = Trackers.get_timer!(id)
    {:ok, _timer} = Trackers.delete_timer(timer)

    conn
    |> put_flash(:info, "Timer deleted successfully.")
    |> redirect(to: Routes.timer_path(conn, :index))
  end
end
