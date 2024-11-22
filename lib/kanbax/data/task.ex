defmodule Kanbax.Data.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias Kanbax.Data.{Project, Task, User}

  schema "tasks" do
    field(:title, :string)
    field(:description, :string)
    field(:state, :string, default: "idle")
    field(:time_spent, :integer, default: 0)
    field(:due, :utc_datetime)
    belongs_to(:project, Project)
    belongs_to(:user, User)
    timestamps(type: :utc_datetime)
  end

  def changeset(task, params) do
    task
    |> cast(params, ~w[title description due]a)
    |> cast_embed(:project, with: &Project.changeset/2)
    |> validate_required(~w[title due]a)
    |> validate_inclusion(:state, ["idle", "in_progress", "done"])
  end

  def create(params) when is_list(params), do: params |> Map.new() |> create()

  def create(params) when is_map(params) do
    %Task{}
    |> changeset(params)
    |> case do
      %Ecto.Changeset{valid?: false, errors: errors} -> {:error, errors}
      changeset -> apply_changes(changeset)
    end
  end

  def create(title, due_days, project_title, description \\ nil, project_description \\ nil) do
    create(
      title: title,
      due: DateTime.add(DateTime.utc_now(), due_days, :day),
      description: description,
      project: %{title: project_title, description: project_description}
    )
  end
end
