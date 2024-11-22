defmodule Kanbax.Data.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Kanbax.Repo
  alias Kanbax.Data.{Task, User}

  schema "users" do
    field(:name, :string)
    field(:password, :string, redact: true)
    has_many(:tasks, Task)
    timestamps(type: :utc_datetime)
  end

  def changeset(user, params) do
    user
    |> cast(params, [:name, :password])
    |> validate_required([:name, :password])
  end

  def create(params) when is_list(params), do: params |> Map.new() |> create()

  def create(params) when is_map(params) do
    %User{}
    |> changeset(params)
    |> case do
      %Ecto.Changeset{valid?: false, errors: errors} -> {:error, errors}
      changeset -> Repo.insert(changeset)
    end
  end
end
