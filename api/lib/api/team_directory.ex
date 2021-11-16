defmodule Api.TeamDirectory do
  @moduledoc """
  The TeamDirectory context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.TeamDirectory.Teams

  @doc """
  Returns the list of team.

  ## Examples

      iex> list_team()
      [%Teams{}, ...]

  """
  def list_team do
    Repo.all(Teams)
  end

  @doc """
  Gets a single teams.

  Raises `Ecto.NoResultsError` if the Teams does not exist.

  ## Examples

      iex> get_teams!(123)
      %Teams{}

      iex> get_teams!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teams!(id), do: Repo.get!(Teams, id)

  @doc """
  Creates a teams.

  ## Examples

      iex> create_teams(%{field: value})
      {:ok, %Teams{}}

      iex> create_teams(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teams(attrs \\ %{}) do
    %Teams{}
    |> Teams.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a teams.

  ## Examples

      iex> update_teams(teams, %{field: new_value})
      {:ok, %Teams{}}

      iex> update_teams(teams, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_teams(%Teams{} = teams, attrs) do
    teams
    |> Teams.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a teams.

  ## Examples

      iex> delete_teams(teams)
      {:ok, %Teams{}}

      iex> delete_teams(teams)
      {:error, %Ecto.Changeset{}}

  """
  def delete_teams(%Teams{} = teams) do
    Repo.delete(teams)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking teams changes.

  ## Examples

      iex> change_teams(teams)
      %Ecto.Changeset{data: %Teams{}}

  """
  def change_teams(%Teams{} = teams, attrs \\ %{}) do
    Teams.changeset(teams, attrs)
  end
end
