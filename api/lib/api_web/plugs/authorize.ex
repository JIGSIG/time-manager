defmodule ApiWeb.Authorize do
  import Plug.Conn
  import Phoenix.Controller
  import Api.Authorization
  import Api.Auth.AuthFlow

  def init(opts), do: opts

  def call(conn, opts) do
    try do
      req_headers = Map.new(conn.req_headers)
      private = Map.new(conn.private)
      IO.puts('Kernel.inspect(private)')
      IO.puts(Kernel.inspect(private))
      IO.puts('Kernel.inspect(private["role"])')
      IO.puts(Kernel.inspect(private[:role]))
      role = if private[:role] == nil, do: "", else: private[:role]
      resource = Keyword.get(opts, :resource)
      action = action_name(conn)

      check(action, role, resource)
      |> maybe_continue(conn)
    rescue
      Ecto.NoResultsError ->
        false |> maybe_continue(conn)
    end
  end

  defp maybe_continue(true, conn), do: conn

  defp maybe_continue(false, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, "You're not authorized to do that!")
    |> halt()
  end

  defp check(:index, role, resource) do
    can(role) |> read?(resource)
  end

  defp check(action, role, resource) when action in [:show, :showByData] do
    can(role) |> read?(resource)
  end

  defp check(action, role, resource) when action in [:new, :create] do
    can(role) |> create?(resource)
  end

  defp check(action, role, resource) when action in [:edit, :update] do
    can(role) |> update?(resource)
  end

  defp check(:delete, role, resource) do
    can(role) |> delete?(resource)
  end

  defp check(_action, _role, _resource), do: false

end