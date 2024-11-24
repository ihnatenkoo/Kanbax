defmodule Kanbax.TaskManager do
  use DynamicSupervisor

  alias Kanbax.Data.Task

  def start_link(init_arg \\ []) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: Kanbax.TaskManager)
  end

  @impl DynamicSupervisor
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def create_task(%Task{} = task) do
    Kanbax.TaskManager
    |> DynamicSupervisor.start_child({Kanbax.TaskFSM, task})
    |> case do
      {:ok, pid} ->
        Kanbax.State.put(task.title, task.state)
        pid

      {:error, {:already_started, pid}} ->
        pid
    end
  end

  def create_task(project_id, title, due_days, description) do
    {:ok, task} = Task.create(project_id, title, due_days, description)
    create_task(task)
  end
end
