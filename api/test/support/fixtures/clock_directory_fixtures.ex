defmodule Api.ClockDirectoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.ClockDirectory` context.
  """

  @doc """
  Generate a clocks.
  """
  def clocks_fixture(attrs \\ %{}) do
    {:ok, clocks} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2021-10-26 11:28:00]
      })
      |> Api.ClockDirectory.create_clocks()

    clocks
  end
end
