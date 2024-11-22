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

  def start_task(%Task{} = task) do
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

  def start_task(title, due_days, project_title) do
    Task.create(title, due_days, project_title)
    |> start_task()
  end
end
