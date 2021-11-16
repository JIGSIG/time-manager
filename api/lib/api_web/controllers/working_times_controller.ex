defmodule ApiWeb.WorkingTimesController do
  use ApiWeb, :controller

  alias Api.WorkingTimeDirectory
  alias Api.WorkingTimeDirectory.WorkingTimes

  action_fallback ApiWeb.FallbackController

  plug ApiWeb.Authorize, resource: Api.WorkingTimeDirectory.WorkingTimes

  def index(conn, _params) do
    workingtime = WorkingTimeDirectory.list_workingtime()
    render(conn, "index.json", workingtime: workingtime)
  end

  def create(conn, params) do
    try do
      required_keys = [ "start", "end", "userID" ]
      result = required_keys |> Enum.all?(&(Map.has_key?(params, &1)))
      if result == false do
        raise "oops"
      end
      working_times_params = %{
        start: params["start"],
        end: params["end"],
        user: params["userID"]
      }
      with {:ok, %WorkingTimes{} = working_times} <- WorkingTimeDirectory.create_working_times(working_times_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.working_times_path(conn, :show, working_times))
        |> render("show.json", working_times: working_times)
      end

    rescue
      RuntimeError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"bad data\":[\"the data sent are not good\"]}}")
      Ecto.NoResultsError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"id\":[\"does not exist\"]}}")
    end
  end

  def show(conn, params) do
    try do
      id = params["id"]
      if id == nil do
        raise "oops"
      end
      required_keys = [ "start", "end" ]
      result = required_keys |> Enum.any?(&(Map.has_key?(params, &1)))
      cond do
        result == false ->
          working_times = WorkingTimeDirectory.get_working_times!(id)
          render(conn, "show.json", working_times: working_times)
        true            ->
          Api.Users.get_user!(id)
          startDate = params["start"] || "1500-01-01 00:00:00"
          endDate = params["end"] || "2500-12-31 23:59:59"
          workingtime = WorkingTimeDirectory.list_workingtime_with_filter(id, startDate, endDate)
          render(conn, "index.json", workingtime: workingtime)
      end

    rescue
      RuntimeError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"bad data\":[\"the data sent are not good\"]}}")
      Ecto.NoResultsError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"id\":[\"does not exist\"]}}")
    end
  end

  def update(conn, params) do
    try do
      required_keys = [ "start", "end", "id" ]
      result = required_keys |> Enum.all?(&(Map.has_key?(params, &1)))
      if result == false do
        raise "oops"
      end
      id = params["id"]
      working_times_params = %{
        start: params["start"],
        end: params["end"],
      }
      working_times = WorkingTimeDirectory.get_working_times!(id)
      with {:ok, %WorkingTimes{} = working_times} <- WorkingTimeDirectory.update_working_times(working_times, working_times_params) do
        render(conn, "show.json", working_times: working_times)
      end

    rescue
      RuntimeError ->
       conn
       |> put_resp_content_type("application/json")
       |> send_resp(404, "{\"errors\":{\"bad data\":[\"the data sent are not good\"]}}")
      Ecto.NoResultsError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"id\":[\"does not exist\"]}}")
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      working_times = WorkingTimeDirectory.get_working_times!(id)
      with {:ok, %WorkingTimes{}} <- WorkingTimeDirectory.delete_working_times(working_times) do
        send_resp(conn, :no_content, "")
      end

    rescue
      RuntimeError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"bad data\":[\"the data sent are not good\"]}}")
      Ecto.NoResultsError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"id\":[\"does not exist\"]}}")
    end
  end
end
