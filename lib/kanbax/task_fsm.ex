defmodule Kanbax.TaskFSM do
  @moduledoc """
  This module is responsible for starting the Kanbax application.
  """

  use GenServer

  alias Kanbax.Data.Task

  def start_link(%Task{state: "idle", title: title} = task) do
    GenServer.start_link(__MODULE__, task, name: {:via, Registry, {Kanbax.TaskRegistry, title}})
  end

  def start(pid) do
    GenServer.call(pid, {:transition, :start})
  end

  def finish(pid) do
    GenServer.call(pid, {:transition, :finish})
  end

  def state(pid) do
    GenServer.call(pid, :state)
  end

  @impl GenServer
  def init(state), do: {:ok, state}

  @impl GenServer
  # "idle", "in_progress", "done"
  def handle_call({:transition, :start}, _from, %Task{state: "idle"} = task) do
    # task = Task.update(task)
    {:reply, :ok, %Task{task | state: "in_progress"}}
  end

  def handle_call({:transition, :finish}, _from, %Task{state: "in_progress"} = task) do
    {:stop, :normal, :ok, %Task{task | state: "done"}}
  end

  def handle_call(:state, _from, %Task{state: state} = task) do
    {:reply, state, task}
  end

  def handle_call({:transition, transition}, _from, %Task{state: state} = task) do
    {:reply, {:error, {:not_allowed, transition, state}}, task}
  end
end
