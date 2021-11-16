defmodule Api.TeamDirectoryTest do
  use Api.DataCase

  alias Api.TeamDirectory

  describe "team" do
    alias Api.TeamDirectory.Teams

    import Api.TeamDirectoryFixtures

    @invalid_attrs %{members: nil, name: nil}

    test "list_team/0 returns all team" do
      teams = teams_fixture()
      assert TeamDirectory.list_team() == [teams]
    end

    test "get_teams!/1 returns the teams with given id" do
      teams = teams_fixture()
      assert TeamDirectory.get_teams!(teams.id) == teams
    end

    test "create_teams/1 with valid data creates a teams" do
      valid_attrs = %{members: [], name: "some name"}

      assert {:ok, %Teams{} = teams} = TeamDirectory.create_teams(valid_attrs)
      assert teams.members == []
      assert teams.name == "some name"
    end

    test "create_teams/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamDirectory.create_teams(@invalid_attrs)
    end

    test "update_teams/2 with valid data updates the teams" do
      teams = teams_fixture()
      update_attrs = %{members: [], name: "some updated name"}

      assert {:ok, %Teams{} = teams} = TeamDirectory.update_teams(teams, update_attrs)
      assert teams.members == []
      assert teams.name == "some updated name"
    end

    test "update_teams/2 with invalid data returns error changeset" do
      teams = teams_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamDirectory.update_teams(teams, @invalid_attrs)
      assert teams == TeamDirectory.get_teams!(teams.id)
    end

    test "delete_teams/1 deletes the teams" do
      teams = teams_fixture()
      assert {:ok, %Teams{}} = TeamDirectory.delete_teams(teams)
      assert_raise Ecto.NoResultsError, fn -> TeamDirectory.get_teams!(teams.id) end
    end

    test "change_teams/1 returns a teams changeset" do
      teams = teams_fixture()
      assert %Ecto.Changeset{} = TeamDirectory.change_teams(teams)
    end
  end
end
