defmodule TodoLiveViewWeb.FormComponent do
  use TodoLiveViewWeb, :live_component
  alias TodoLiveView.Todos

  @impl true
  def update(%{todo: todo} = assigns, socket) do
    changeset = Todos.change_todo(todo)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end
end
