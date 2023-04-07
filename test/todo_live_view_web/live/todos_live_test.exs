defmodule TodoLiveViewWeb.TodosLiveTest do
  use TodoLiveViewWeb.ConnCase
  import Phoenix.LiveViewTest

  @create_todo_attrs %{text: "first item"}
  @invalid_todo_attrs %{text: nil}

  test "create todo", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert view
           |> form("#todo-form", todo: @invalid_todo_attrs)
           |> render_change() =~ "can&#39;t be blank"

    view
    |> form("#todo-form", todo: @create_todo_attrs)
    |> render_submit()

    assert render(view) =~ "first item"
  end
end
