defmodule LoginAppWeb.CoursesLiveTest do
  use LoginAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import LoginApp.SchoolFixtures

  @create_attrs %{name: "some name", description: "some description", course_id: "some course_id"}
  @update_attrs %{name: "some updated name", description: "some updated description", course_id: "some updated course_id"}
  @invalid_attrs %{name: nil, description: nil, course_id: nil}

  defp create_courses(_) do
    courses = courses_fixture()
    %{courses: courses}
  end

  describe "Index" do
    setup [:create_courses]

    test "lists all courses", %{conn: conn, courses: courses} do
      {:ok, _index_live, html} = live(conn, ~p"/courses")

      assert html =~ "Listing Courses"
      assert html =~ courses.name
    end

    test "saves new courses", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/courses")

      assert index_live |> element("a", "New Courses") |> render_click() =~
               "New Courses"

      assert_patch(index_live, ~p"/courses/new")

      assert index_live
             |> form("#courses-form", courses: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#courses-form", courses: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/courses")

      html = render(index_live)
      assert html =~ "Courses created successfully"
      assert html =~ "some name"
    end

    test "updates courses in listing", %{conn: conn, courses: courses} do
      {:ok, index_live, _html} = live(conn, ~p"/courses")

      assert index_live |> element("#courses-#{courses.id} a", "Edit") |> render_click() =~
               "Edit Courses"

      assert_patch(index_live, ~p"/courses/#{courses}/edit")

      assert index_live
             |> form("#courses-form", courses: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#courses-form", courses: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/courses")

      html = render(index_live)
      assert html =~ "Courses updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes courses in listing", %{conn: conn, courses: courses} do
      {:ok, index_live, _html} = live(conn, ~p"/courses")

      assert index_live |> element("#courses-#{courses.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#courses-#{courses.id}")
    end
  end

  describe "Show" do
    setup [:create_courses]

    test "displays courses", %{conn: conn, courses: courses} do
      {:ok, _show_live, html} = live(conn, ~p"/courses/#{courses}")

      assert html =~ "Show Courses"
      assert html =~ courses.name
    end

    test "updates courses within modal", %{conn: conn, courses: courses} do
      {:ok, show_live, _html} = live(conn, ~p"/courses/#{courses}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Courses"

      assert_patch(show_live, ~p"/courses/#{courses}/show/edit")

      assert show_live
             |> form("#courses-form", courses: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#courses-form", courses: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/courses/#{courses}")

      html = render(show_live)
      assert html =~ "Courses updated successfully"
      assert html =~ "some updated name"
    end
  end
end
