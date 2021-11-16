defmodule ApiWeb.TeamsControllerTest do
  use ApiWeb.ConnCase

  import Api.TeamDirectoryFixtures

  alias Api.TeamDirectory.Teams

  @create_attrs %{
    members: [],
    name: "some name"
  }
  @update_attrs %{
    members: [],
    name: "some updated name"
  }
  @invalid_attrs %{members: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all team", %{conn: conn} do
      conn = get(conn, Routes.teams_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create teams" do
    test "renders teams when data is valid", %{conn: conn} do
      conn = post(conn, Routes.teams_path(conn, :create), teams: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.teams_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "members" => [],
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.teams_path(conn, :create), teams: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update teams" do
    setup [:create_teams]

    test "renders teams when data is valid", %{conn: conn, teams: %Teams{id: id} = teams} do
      conn = put(conn, Routes.teams_path(conn, :update, teams), teams: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.teams_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "members" => [],
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, teams: teams} do
      conn = put(conn, Routes.teams_path(conn, :update, teams), teams: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete teams" do
    setup [:create_teams]

    test "deletes chosen teams", %{conn: conn, teams: teams} do
      conn = delete(conn, Routes.teams_path(conn, :delete, teams))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.teams_path(conn, :show, teams))
      end
    end
  end

  defp create_teams(_) do
    teams = teams_fixture()
    %{teams: teams}
  end
end
