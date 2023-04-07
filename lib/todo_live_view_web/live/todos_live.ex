defmodule TodoLiveViewWeb.TodosLive do
  use TodoLiveViewWeb, :live_view
  alias TodoLiveView.Todos
  alias TodoLiveView.Todos.Todo

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, items: Todos.list_todos())
     |> assign_todo()}
  end

  def assign_todo(socket) do
    socket
    |> assign(:todo, %Todo{})
  end
end
