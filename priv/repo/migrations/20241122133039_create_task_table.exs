defmodule Kanbax.Repo.Migrations.CreateTaskTable do
  use Ecto.Migration
  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text
      add :state, :string, default: "idle"
      add :time_spent, :integer, default: 0
      add :due, :utc_datetime
      add :project_id, references(:projects, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end

    create index(:tasks, [:project_id])
    create index(:tasks, [:user_id])
  end
end
