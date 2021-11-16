defmodule ApiWeb.ClocksController do
  use ApiWeb, :controller

  alias Api.ClockDirectory
  alias Api.ClockDirectory.Clocks

  action_fallback ApiWeb.FallbackController

  plug ApiWeb.Authorize, resource: Api.ClockDirectory.Clocks

  def index(conn, params) do
    try do
      userID = params["userID"]
      Api.Users.get_user!(userID)
      clock = ClockDirectory.list_clock(userID)
      render(conn, "index.json", clock: clock)

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

  def create(conn, %{"userID" => userID}) do
    try do
      Api.Users.get_user!(userID)
      lastClock = ClockDirectory.get_clocks_by_uid!(userID)
      clocks_params = Map.put(%{}, "user", userID)
      clocks_params = Map.put(clocks_params, "time", NaiveDateTime.local_now())
      clocks_params = Map.put(clocks_params, "status", !(if lastClock != nil, do:  lastClock.status, else: false))
      with {:ok, %Clocks{} = clocks} <- ClockDirectory.create_clocks(clocks_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
        |> render("show.json", clocks: clocks)
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
      userID = params["userID"]
      all = params["all"]
      Api.Users.get_user!(userID)
      cond do
        all == nil ->
          clocks = ClockDirectory.get_clocks_by_uid!(userID)
          render(conn, "show.json", clocks: clocks)
        true        ->
          clock = ClockDirectory.list_clock(userID)
          render(conn, "index.json", clock: clock)
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

  def update(conn, %{"id" => id, "clocks" => clocks_params}) do
    clocks = ClockDirectory.get_clocks!(id)

    with {:ok, %Clocks{} = clocks} <- ClockDirectory.update_clocks(clocks, clocks_params) do
      render(conn, "show.json", clocks: clocks)
    end
  end

  def delete(conn, %{"id" => id}) do
    clocks = ClockDirectory.get_clocks!(id)

    with {:ok, %Clocks{}} <- ClockDirectory.delete_clocks(clocks) do
      send_resp(conn, :no_content, "")
    end
  end
end
