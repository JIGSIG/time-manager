defmodule ApiWeb.WorkingTimesView do
  use ApiWeb, :view
  alias ApiWeb.WorkingTimesView

  def render("index.json", %{workingtime: workingtime}) do
    %{data: render_many(workingtime, WorkingTimesView, "working_times.json")}
  end

  def render("show.json", %{working_times: working_times}) do
    %{data: render_one(working_times, WorkingTimesView, "working_times.json")}
  end

  def render("working_times.json", %{working_times: working_times}) do
    %{
      id: working_times.id,
      start: NaiveDateTime.to_string(working_times.start),
      end: NaiveDateTime.to_string(working_times.end)
    }
  end
end
