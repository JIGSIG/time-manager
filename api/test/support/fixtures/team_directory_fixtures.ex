defmodule Api.TeamDirectoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.TeamDirectory` context.
  """

  @doc """
  Generate a teams.
  """
  def teams_fixture(attrs \\ %{}) do
    {:ok, teams} =
      attrs
      |> Enum.into(%{
        members: [],
        name: "some name"
      })
      |> Api.TeamDirectory.create_teams()

    teams
  end
end
