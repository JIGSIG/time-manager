defmodule Api.ClockDirectoryTest do
  use Api.DataCase

  alias Api.ClockDirectory

  describe "clock" do
    alias Api.ClockDirectory.Clocks

    import Api.ClockDirectoryFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clock/0 returns all clock" do
      clocks = clocks_fixture()
      assert ClockDirectory.list_clock() == [clocks]
    end

    test "get_clocks!/1 returns the clocks with given id" do
      clocks = clocks_fixture()
      assert ClockDirectory.get_clocks!(clocks.id) == clocks
    end

    test "create_clocks/1 with valid data creates a clocks" do
      valid_attrs = %{status: true, time: ~N[2021-10-26 11:28:00]}

      assert {:ok, %Clocks{} = clocks} = ClockDirectory.create_clocks(valid_attrs)
      assert clocks.status == true
      assert clocks.time == ~N[2021-10-26 11:28:00]
    end

    test "create_clocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ClockDirectory.create_clocks(@invalid_attrs)
    end

    test "update_clocks/2 with valid data updates the clocks" do
      clocks = clocks_fixture()
      update_attrs = %{status: false, time: ~N[2021-10-27 11:28:00]}

      assert {:ok, %Clocks{} = clocks} = ClockDirectory.update_clocks(clocks, update_attrs)
      assert clocks.status == false
      assert clocks.time == ~N[2021-10-27 11:28:00]
    end

    test "update_clocks/2 with invalid data returns error changeset" do
      clocks = clocks_fixture()
      assert {:error, %Ecto.Changeset{}} = ClockDirectory.update_clocks(clocks, @invalid_attrs)
      assert clocks == ClockDirectory.get_clocks!(clocks.id)
    end

    test "delete_clocks/1 deletes the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{}} = ClockDirectory.delete_clocks(clocks)
      assert_raise Ecto.NoResultsError, fn -> ClockDirectory.get_clocks!(clocks.id) end
    end

    test "change_clocks/1 returns a clocks changeset" do
      clocks = clocks_fixture()
      assert %Ecto.Changeset{} = ClockDirectory.change_clocks(clocks)
    end
  end
end
