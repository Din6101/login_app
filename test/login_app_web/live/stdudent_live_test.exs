defmodule LoginAppWeb.StdudentLiveTest do
  use LoginAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import LoginApp.SchoolFixtures

  @create_attrs %{name: "some name", users: "some users", age: 42, grade: "some grade"}
  @update_attrs %{name: "some updated name", users: "some updated users", age: 43, grade: "some updated grade"}
  @invalid_attrs %{name: nil, users: nil, age: nil, grade: nil}

  defp create_stdudent(_) do
    stdudent = stdudent_fixture()
    %{stdudent: stdudent}
  end

  describe "Index" do
    setup [:create_stdudent]

    test "lists all students", %{conn: conn, stdudent: stdudent} do
      {:ok, _index_live, html} = live(conn, ~p"/students")

      assert html =~ "Listing Students"
      assert html =~ stdudent.name
    end

    test "saves new stdudent", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("a", "New Stdudent") |> render_click() =~
               "New Stdudent"

      assert_patch(index_live, ~p"/students/new")

      assert index_live
             |> form("#stdudent-form", stdudent: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#stdudent-form", stdudent: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/students")

      html = render(index_live)
      assert html =~ "Stdudent created successfully"
      assert html =~ "some name"
    end

    test "updates stdudent in listing", %{conn: conn, stdudent: stdudent} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("#students-#{stdudent.id} a", "Edit") |> render_click() =~
               "Edit Stdudent"

      assert_patch(index_live, ~p"/students/#{stdudent}/edit")

      assert index_live
             |> form("#stdudent-form", stdudent: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#stdudent-form", stdudent: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/students")

      html = render(index_live)
      assert html =~ "Stdudent updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes stdudent in listing", %{conn: conn, stdudent: stdudent} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("#students-#{stdudent.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#students-#{stdudent.id}")
    end
  end

  describe "Show" do
    setup [:create_stdudent]

    test "displays stdudent", %{conn: conn, stdudent: stdudent} do
      {:ok, _show_live, html} = live(conn, ~p"/students/#{stdudent}")

      assert html =~ "Show Stdudent"
      assert html =~ stdudent.name
    end

    test "updates stdudent within modal", %{conn: conn, stdudent: stdudent} do
      {:ok, show_live, _html} = live(conn, ~p"/students/#{stdudent}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Stdudent"

      assert_patch(show_live, ~p"/students/#{stdudent}/show/edit")

      assert show_live
             |> form("#stdudent-form", stdudent: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#stdudent-form", stdudent: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/students/#{stdudent}")

      html = render(show_live)
      assert html =~ "Stdudent updated successfully"
      assert html =~ "some updated name"
    end
  end
end
