defmodule TodoLiveViewWeb.TodosLiveTest do
  use TodoLiveViewWeb.ConnCase
  import Phoenix.LiveViewTest
  alias TodoLiveView.Todos

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

  test "toggle todo item", %{conn: conn} do
    {:ok, todo} = Todos.create_todo(%{"text" => "first item"})
    assert todo.completed == false

    {:ok, view, _html} = live(conn, "/")
    assert view |> element("#item_completed") |> render_click() =~ "completed"

    updated_todo = Todos.get_todo!(todo.id)
    assert updated_todo.completed == true
  end

  test "delete todo item", %{conn: conn} do
    {:ok, todo} = Todos.create_todo(%{"text" => "first item"})
    assert todo.completed == false

    {:ok, view, _html} = live(conn, "/")
    view |> element("button", "Delete") |> render_click()
    refute has_element?(view, "#item-#{todo.id}")
  end

  test "Filter todo items", %{conn: conn} do
    {:ok, _first_todo} = Todos.create_todo(%{"text" => "first item"})
    {:ok, _second_todo} = Todos.create_todo(%{"text" => "second item"})

    {:ok, view, _html} = live(conn, "/")

    # complete first item
    assert view |> element("p", "first item") |> render_click() =~
             "completed"

    # completed first item should be visible
    {:ok, view, _html} = live(conn, "/?filter_by=completed")
    assert render(view) =~ "first item"
    refute render(view) =~ "second item"

    # active second item should be visible
    {:ok, view, _html} = live(conn, "/?filter_by=active")
    refute render(view) =~ "first item"
    assert render(view) =~ "second item"

    # All items should be visible
    {:ok, view, _html} = live(conn, "/?filter_by=all")
    assert render(view) =~ "first item"
    assert render(view) =~ "second item"
  end
end
