defmodule ApiWeb.ClocksView do
  use ApiWeb, :view
  alias ApiWeb.ClocksView

  def render("index.json", %{clock: clock}) do
    %{data: render_many(clock, ClocksView, "clocks.json")}
  end

  def render("show.json", %{clocks: clocks}) do
    %{data: render_one(clocks, ClocksView, "clocks.json")}
  end

  def render("clocks.json", %{clocks: clocks}) do
    %{
      id: clocks.id,
      time: NaiveDateTime.to_string(clocks.time),
      status: clocks.status
    }
  end
end
