defmodule ApiWeb.TeamsView do
  use ApiWeb, :view
  alias ApiWeb.TeamsView

  def render("index.json", %{team: team}) do
    %{data: render_many(team, TeamsView, "teams.json")}
  end

  def render("show.json", %{teams: teams}) do
    %{data: render_one(teams, TeamsView, "teams.json")}
  end

  def render("teams.json", %{teams: teams}) do
    %{
      id: teams.id,
      members: teams.members,
      name: teams.name,
      manager: teams.manager
    }
  end
end
