defmodule Kanbax.State do
  @moduledoc """
  Holder of `task_id => state` mapping.
  """

  use GenServer

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  @impl GenServer
  def init(state) do
    {:ok, state}
  end

  def put(name \\ __MODULE__, k, v) do
    GenServer.cast(name, {:put, k, v})
  end

  def get(name \\ __MODULE__, k) do
    GenServer.call(name, {:get, k})
  end

  def delete(name \\ __MODULE__, k) do
    GenServer.cast(name, {:delete, k})
  end

  def state(name \\ __MODULE__) do
    GenServer.call(name, :state)
  end

  @impl GenServer
  def handle_cast({:put, k, v}, state) do
    {:noreply, Map.put(state, k, v)}
  end

  def handle_cast({:delete, k}, state) do
    {:noreply, Map.delete(state, k)}
  end

  @impl GenServer
  def handle_call({:get, k}, _from, state) do
    {:reply, Map.get(state, k), state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end
end
