defmodule Api.WorkingTimeDirectoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.WorkingTimeDirectory` context.
  """

  @doc """
  Generate a working_times.
  """
  def working_times_fixture(attrs \\ %{}) do
    {:ok, working_times} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-10-26 11:27:00],
        start: ~N[2021-10-26 11:27:00]
      })
      |> Api.WorkingTimeDirectory.create_working_times()

    working_times
  end
end
