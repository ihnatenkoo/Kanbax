defmodule Kanbax.Data.Project do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:title, :string)
    field(:description, :string)
  end

  def changeset(project, params) do
    project
    |> cast(params, ~w[title description]a)
    |> validate_required(~w[title]a)
  end
end
