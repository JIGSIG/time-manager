defmodule Api.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:team) do
      add :members, {:array, :integer}, null: false
      add :name, :string, null: false
      add :manager, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:team, [:manager])
  end
end
