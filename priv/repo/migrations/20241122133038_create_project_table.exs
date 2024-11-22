defmodule Kanbax.Repo.Migrations.CreateProjectTable do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :title, :string, null: false
      add :description, :text
      timestamps()
    end
  end
end
