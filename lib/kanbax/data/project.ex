defmodule Kanbax.Data.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias Kanbax.Repo
  alias Kanbax.Data.Project

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

  def create(params) when is_list(params), do: params |> Map.new() |> create()

  def create(params) when is_map(params) do
    %Project{}
    |> changeset(params)
    |> case do
      %Ecto.Changeset{valid?: false, errors: errors} -> {:error, errors}
      changeset -> Repo.insert(changeset)
    end
  end
end
