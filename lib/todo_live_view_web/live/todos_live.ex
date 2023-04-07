defmodule TodoLiveViewWeb.TodosLive do
  use TodoLiveViewWeb, :live_view
  alias TodoLiveView.Todos
  alias TodoLiveView.Todos.Todo

  @todos_topic "todos"

  def mount(_params, _session, socket) do
    if connected?(socket), do: TodoLiveViewWeb.Endpoint.subscribe(@todos_topic)

    {:ok,
     assign(socket, items: Todos.list_todos())
     |> assign_todo()}
  end

  def assign_todo(socket) do
    socket
    |> assign(:todo, %Todo{})
  end

  def handle_info(%{event: "todos_updated", payload: %{items: items}}, socket) do
    {:noreply, assign(socket, items: items)}
  end
end
