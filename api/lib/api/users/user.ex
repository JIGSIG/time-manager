defmodule Api.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :username, :string, null: false
    field :role, :string, null: false, default: "user"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password_hash, :role])
    |> validate_required([:username, :email, :password_hash, :role])
    |> update_change(:email, &String.downcase/1)
    |> update_change(:password_hash, &Bcrypt.hashpwsalt/1)
    |> validate_format(:email, ~r/^\S+@\S+\.\S+$/)
    |> validate_inclusion(:role, ~w(user manager admin))
    |> unique_constraint([:email])
  end

  @spec changeset_role(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(user manager admin))
  end
end
