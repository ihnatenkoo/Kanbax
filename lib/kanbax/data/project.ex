defmodule Kanbax.Data.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field(:title, :string)
    field(:description, :string)
    has_many(:tasks, Kanbax.Data.Task)
    timestamps(type: :utc_datetime)
  end

  def changeset(project, params) do
    project
    |> cast(params, ~w[title description]a)
    |> validate_required(~w[title]a)
  end
end
