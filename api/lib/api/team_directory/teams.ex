defmodule Api.TeamDirectory.Teams do
  use Ecto.Schema
  import Ecto.Changeset

  schema "team" do
    field :members, {:array, :integer}
    field :name, :string
    field :manager, :id
    
    timestamps()
  end

  @doc false
  def changeset(teams, attrs) do
    teams
    |> cast(attrs, [:members, :name, :manager])
    |> validate_required([:members, :name, :manager])
    |> unique_constraint([:manager])
  end
end
