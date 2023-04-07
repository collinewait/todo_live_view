defmodule TodoLiveViewWeb.TodosListComponent do
  use TodoLiveViewWeb, :live_component
  alias TodoLiveView.Todos

  @todos_topic "todos"

  def handle_event("toggle_todo", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)
    Todos.update_todo(todo, %{completed: !todo.completed})

    socket = assign(socket, items: Todos.list_todos())
    TodoLiveViewWeb.Endpoint.broadcast(@todos_topic, "todos_updated", socket.assigns)
    {:noreply, socket}
  end

  def item_completed?(item) do
    if item.completed == true, do: "completed", else: ""
  end
end
