defmodule Kanbax.Repo.Migrations.RequiredProjectIdInTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      modify :project_id, :bigint, null: false
    end
  end
end
