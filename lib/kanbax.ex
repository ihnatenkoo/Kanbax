defmodule Kanbax do
  @moduledoc """
  Documentation for `Kanbax`.
  """

  alias Kanbax.TaskFSM
  alias Kanbax.TaskManager

  def create_task(title, due_days, project_title) do
    TaskManager.create_task(title, due_days, project_title)
  end

  def start_task(task_id) do
    TaskFSM.start({:via, Registry, {Kanbax.TaskRegistry, task_id}})
  end

  def finish_task(task_id) do
    TaskFSM.finish({:via, Registry, {Kanbax.TaskRegistry, task_id}})
  end

  def state_task(task_id) do
    case Registry.lookup(Kanbax.TaskRegistry, task_id) do
      [{_pid, _value}] -> TaskFSM.state({:via, Registry, {Kanbax.TaskRegistry, task_id}})
      [] -> {:error, "Task not found"}
    end
  end
end
