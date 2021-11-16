defmodule Api.WorkingTimeDirectoryTest do
  use Api.DataCase

  alias Api.WorkingTimeDirectory

  describe "workingtime" do
    alias Api.WorkingTimeDirectory.WorkingTimes

    import Api.WorkingTimeDirectoryFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtime/0 returns all workingtime" do
      working_times = working_times_fixture()
      assert WorkingTimeDirectory.list_workingtime() == [working_times]
    end

    test "get_working_times!/1 returns the working_times with given id" do
      working_times = working_times_fixture()
      assert WorkingTimeDirectory.get_working_times!(working_times.id) == working_times
    end

    test "create_working_times/1 with valid data creates a working_times" do
      valid_attrs = %{end: ~N[2021-10-26 11:27:00], start: ~N[2021-10-26 11:27:00]}

      assert {:ok, %WorkingTimes{} = working_times} = WorkingTimeDirectory.create_working_times(valid_attrs)
      assert working_times.end == ~N[2021-10-26 11:27:00]
      assert working_times.start == ~N[2021-10-26 11:27:00]
    end

    test "create_working_times/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WorkingTimeDirectory.create_working_times(@invalid_attrs)
    end

    test "update_working_times/2 with valid data updates the working_times" do
      working_times = working_times_fixture()
      update_attrs = %{end: ~N[2021-10-27 11:27:00], start: ~N[2021-10-27 11:27:00]}

      assert {:ok, %WorkingTimes{} = working_times} = WorkingTimeDirectory.update_working_times(working_times, update_attrs)
      assert working_times.end == ~N[2021-10-27 11:27:00]
      assert working_times.start == ~N[2021-10-27 11:27:00]
    end

    test "update_working_times/2 with invalid data returns error changeset" do
      working_times = working_times_fixture()
      assert {:error, %Ecto.Changeset{}} = WorkingTimeDirectory.update_working_times(working_times, @invalid_attrs)
      assert working_times == WorkingTimeDirectory.get_working_times!(working_times.id)
    end

    test "delete_working_times/1 deletes the working_times" do
      working_times = working_times_fixture()
      assert {:ok, %WorkingTimes{}} = WorkingTimeDirectory.delete_working_times(working_times)
      assert_raise Ecto.NoResultsError, fn -> WorkingTimeDirectory.get_working_times!(working_times.id) end
    end

    test "change_working_times/1 returns a working_times changeset" do
      working_times = working_times_fixture()
      assert %Ecto.Changeset{} = WorkingTimeDirectory.change_working_times(working_times)
    end
  end
end
