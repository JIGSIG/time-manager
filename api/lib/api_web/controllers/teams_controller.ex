defmodule ApiWeb.TeamsController do
  use ApiWeb, :controller

  alias Api.TeamDirectory
  alias Api.TeamDirectory.Teams

  action_fallback ApiWeb.FallbackController

  plug ApiWeb.Authorize, resource: Api.TeamDirectory.Teams

  def index(conn, params) do
    IO.puts(Kernel.inspect(params))
    team = TeamDirectory.list_team()
    render(conn, "index.json", team: team)
  end

  def create(conn, teams_params) do
    IO.puts(Kernel.inspect(teams_params))
    teams_map = %{
      name: teams_params["name"],
      manager: teams_params["manager"],
      members: []
    }
    with {:ok, %Teams{} = teams} <- TeamDirectory.create_teams(teams_map) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.teams_path(conn, :show, teams))
      |> render("show.json", teams: teams)
    end
  end

  def show(conn, %{"id" => id}) do
    teams = TeamDirectory.get_teams!(id)
    render(conn, "show.json", teams: teams)
  end

  def update(conn, %{"id" => id, "teams" => teams_params}) do
    teams = TeamDirectory.get_teams!(id)

    with {:ok, %Teams{} = teams} <- TeamDirectory.update_teams(teams, teams_params) do
      render(conn, "show.json", teams: teams)
    end
  end

  def delete(conn, %{"id" => id}) do
    teams = TeamDirectory.get_teams!(id)

    with {:ok, %Teams{}} <- TeamDirectory.delete_teams(teams) do
      send_resp(conn, :no_content, "")
    end
  end

  def addUserToTeam(conn, %{"teamID" => id, "teams" => teams_params}) do
    try do
      teams = TeamDirectory.get_teams!(id)
      if teams_params["new_member"] in teams.members do
        raise "oops"
      end
      teams_params = Map.put(teams_params, "members", teams.members ++ [teams_params["new_member"]])

      with {:ok, %Teams{} = teams} <- TeamDirectory.update_teams(teams, teams_params) do
        render(conn, "show.json", teams: teams)
      end
    rescue
      RuntimeError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"bad data\":[\"the data sent are not good\"]}}")
      Ecto.NoResultsError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"op\":[\"operation not authorized\"]}}")
    end
  end

  def removeUserToTeam(conn, %{"teamID" => id, "teams" => teams_params}) do
    try do
      teams = TeamDirectory.get_teams!(id)
      if teams_params["old_member"] === teams.manager do
        raise "oops"
      end
      teams_params = Map.put(teams_params, "members", teams.members -- [teams_params["old_member"]])

      with {:ok, %Teams{} = teams} <- TeamDirectory.update_teams(teams, teams_params) do
        render(conn, "show.json", teams: teams)
      end
    rescue
      RuntimeError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"bad data\":[\"the data sent are not good\"]}}")
      Ecto.NoResultsError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"op\":[\"operation not authorized\"]}}")
    end
  end

end
