defmodule Api.WorkingTimeDirectory do
  @moduledoc """
  The WorkingTimeDirectory context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.WorkingTimeDirectory.WorkingTimes

  @doc """
  Returns the list of workingtime.

  ## Examples

      iex> list_workingtime()
      [%WorkingTimes{}, ...]

  """
  def list_workingtime do
    Repo.all(WorkingTimes)
  end

  @doc """
  Returns the list of workingtime with start/end time filter.

  ## Examples

      iex> list_workingtime(start, end)
      [%WorkingTimes{}, ...]

  """
  def list_workingtime_with_filter(userID, startDate, endDate) do
    query =
      from workingTime in WorkingTimes,
           where: workingTime.user == ^userID and workingTime.start >= ^startDate and workingTime.end <= ^endDate,
           select: workingTime
    Repo.all(query)
  end

  @doc """
  Gets a single working_times.

  Raises `Ecto.NoResultsError` if the Working times does not exist.

  ## Examples

      iex> get_working_times!(123)
      %WorkingTimes{}

      iex> get_working_times!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_times!(id), do: Repo.get!(WorkingTimes, id)

  @doc """
  Creates a working_times.

  ## Examples

      iex> create_working_times(%{field: value})
      {:ok, %WorkingTimes{}}

      iex> create_working_times(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_times(attrs \\ %{}) do
    %WorkingTimes{}
    |> WorkingTimes.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a working_times.

  ## Examples

      iex> update_working_times(working_times, %{field: new_value})
      {:ok, %WorkingTimes{}}

      iex> update_working_times(working_times, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_times(%WorkingTimes{} = working_times, attrs) do
    working_times
    |> WorkingTimes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_times.

  ## Examples

      iex> delete_working_times(working_times)
      {:ok, %WorkingTimes{}}

      iex> delete_working_times(working_times)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_times(%WorkingTimes{} = working_times) do
    Repo.delete(working_times)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_times changes.

  ## Examples

      iex> change_working_times(working_times)
      %Ecto.Changeset{data: %WorkingTimes{}}

  """
  def change_working_times(%WorkingTimes{} = working_times, attrs \\ %{}) do
    WorkingTimes.changeset(working_times, attrs)
  end
end
