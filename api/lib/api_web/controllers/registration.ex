defmodule ApiWeb.Controllers.UserRegistration do
  use ApiWeb, :controller

  alias Ecto.Changeset
  alias Plug.Conn
  alias ApiWeb.ErrorHelpers
  alias Api.Auth.UserRegistration


  @spec register(Conn.t(), UserRegistration.t()) :: Conn.t()
  def register(conn, user_registration_command) do
    with {:ok, user, conn} <- conn |> Pow.Plug.create_user(user_registration_command) do
      user_json = %{
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role
      }
      json(conn, %{token: conn.private[:api_access_token], user: user_json})
    else
      {:error, changeset, conn} ->
        errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
        conn
        |> put_status(500)
        |> json(%{error: %{status: 500, message: "Couldn't create user", errors: errors}})
    end
  end
end
