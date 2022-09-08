defmodule TimeTracker.Trackers do
  @moduledoc """
  The Trackers context.
  """

  import Ecto.Query, warn: false
  alias TimeTracker.Repo

  alias TimeTracker.Trackers.Timer

  @doc """
  Returns the list of timers.

  ## Examples

      iex> list_timers()
      [%Timer{}, ...]

  """
  def list_timers do
    Repo.all(Timer)
  end

  @doc """
  Returns all timers for a particular user
  """
  def list_timers_for_user(id) do
    Repo.all(Timer, user_id: 1)
    |> Repo.preload(:project)
  end

  @doc """
  Gets a single timer.

  Raises `Ecto.NoResultsError` if the Timer does not exist.

  ## Examples

      iex> get_timer!(123)
      %Timer{}

      iex> get_timer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timer!(id), do: Repo.get!(Timer, id)

  @doc """
  Creates a timer.

  ## Examples

      iex> create_timer(%{field: value})
      {:ok, %Timer{}}

      iex> create_timer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timer(attrs \\ %{}) do
    %Timer{}
    |> Timer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timer.

  ## Examples

      iex> update_timer(timer, %{field: new_value})
      {:ok, %Timer{}}

      iex> update_timer(timer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timer(%Timer{} = timer, attrs) do
    timer
    |> Timer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Populates the "started_at" column of a timer,
  indicating that it is running
  """
  def start_timer(timer) do
    attrs = %{"started_at" => NaiveDateTime.local_now()}

    timer
    |> Timer.internal_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Gets the diff between "now" and "started_at",
  and adds that to the current timer total
  """
  def stop_timer(timer) do
    elapsed_minutes = round(NaiveDateTime.diff(NaiveDateTime.local_now(), timer.started_at) / 60)
    attrs = %{"started_at" => nil, "total_minutes" => timer.total_minutes + elapsed_minutes}

    timer
    |> Timer.internal_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a timer.

  ## Examples

      iex> delete_timer(timer)
      {:ok, %Timer{}}

      iex> delete_timer(timer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timer(%Timer{} = timer) do
    Repo.delete(timer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timer changes.

  ## Examples

      iex> change_timer(timer)
      %Ecto.Changeset{data: %Timer{}}

  """
  def change_timer(%Timer{} = timer, attrs \\ %{}) do
    Timer.changeset(timer, attrs)
  end
end
