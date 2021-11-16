defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Users
  alias Api.Users.User

  action_fallback ApiWeb.FallbackController

  plug ApiWeb.Authorize, resource: Api.Users.User

  def createUser(conn, data) do
    try do
      with {:ok, %User{} = user} <- Users.create_user(data) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("show.json", user: user)
      end
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(800, "{\"errors\":{\"user\":[\"Something went wrong\"]}}")
    end
  end

  def showByData(conn, params) do
    username = params["username"]
    email = params["email"]
    users = Users.list_users(username, email)
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"userID" => id}) do
    try do
      user = Users.get_user!(id)
      render(conn, "show.json", user: user)
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"id\":[\"does not exist\"]}}")
    end
  end

  def update(conn, %{"userID" => id, "username" => username, "email" => email}) do
    try do
      user = Users.get_user!(id)
      user_params = %{
        "username" => username,
        "email" => email
      }
      with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
        render(conn, "show.json", user: user)
      end
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, "{\"errors\":{\"id\":[\"does not exist\"]}}")
    end
  end

  def delete(conn, %{"userID" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
  end
