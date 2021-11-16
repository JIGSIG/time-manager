defmodule ApiWeb.Controllers.UserLogin do
  use ApiWeb, :controller


  alias Api.Users
  alias Plug.Conn
  alias Api.Auth.UserPassLogin
  alias Comeonin.Bcrypt

  action_fallback ApiWeb.FallbackController


  @spec login(Conn.t(), UserPassLogin.t()) :: Conn.t()
  def login(conn, user_pass_login) do

    with {:ok, conn, user} <- conn |> Users.authenticate_user(user_pass_login) do
      json(conn, %{token: conn.private[:api_access_token], user: user})
    else
      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid email or password"}})
    end
  end

end