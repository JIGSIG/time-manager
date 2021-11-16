defmodule Api.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Plug.Conn
  alias Api.Users.User
  alias Api.Auth.AuthFlow
  alias Comeonin.Bcrypt

  @type t :: %User{}

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_admin(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "admin"})
    |> Repo.insert()
  end

  @spec create_manager(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_manager(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "manager"})
    |> Repo.insert()
  end

  @spec create_user(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "user"})
    |> Repo.insert()
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.changeset_role(%{role: "admin"})
    |> Repo.update()
  end

  @spec set_manager_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_manager_role(user) do
    user
    |> User.changeset_role(%{role: "manager"})
    |> Repo.update()
  end

  @spec set_user_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_user_role(user) do
    user
    |> User.changeset_role(%{role: "user"})
    |> Repo.update()
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users(username, email) do
    cond do
      username != nil && email != nil ->
        query = from(User, where: [email: ^email, username: ^username])
        Repo.one(query)
      username != nil && email == nil ->
        query = from(User, where: [username: ^username])
        Repo.one(query)
      username == nil && email != nil ->
        query = from(User, where: [email: ^email])
        Repo.one(query)
      true        ->
        Repo.all(User)
    end
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  @spec authenticate_user(Plug.Conn.t(), map()) :: {:ok | :error, Plug.Conn.t()}
  def authenticate_user(conn, login_data) do
    try do
      email = login_data["email"]
      password = login_data["password_hash"]
      query = from(User, where: [email: ^email])
      user = Repo.one!(query)
      if Bcrypt.checkpw(password, user.password_hash) === false do
        raise "oops"
      end
      {conn, user} =  AuthFlow.create(conn, user, %{})
      user = %{
        id: user.id,
        email: user.email,
        username: user.username,
        role: user.role,
      }
      {:ok, conn, user}
    rescue
      RuntimeError -> {:error, conn}
      Ecto.NoResultsError -> {:error, conn}
    end
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
