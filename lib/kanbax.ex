defmodule Kanbax do
  @moduledoc """
  Documentation for `Kanbax`.
  """

  alias Kanbax.TaskFSM

  def task_start(task_id) do
    TaskFSM.start({:via, Registry, {Kanbax.TaskRegistry, task_id}})
  end

  def task_finish(task_id) do
    TaskFSM.finish({:via, Registry, {Kanbax.TaskRegistry, task_id}})
  end

  def task_state(task_id) do
    case Registry.lookup(Kanbax.TaskRegistry, task_id) do
      [{_pid, _value}] -> TaskFSM.state({:via, Registry, {Kanbax.TaskRegistry, task_id}})
      [] -> {:error, "Task not found"}
    end
  end
end
