defmodule LoginAppWeb.EnrollmentsLiveTest do
  use LoginAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import LoginApp.SchoolFixtures

  @create_attrs %{name: "some name", description: "some description", course_id: "some course_id"}
  @update_attrs %{name: "some updated name", description: "some updated description", course_id: "some updated course_id"}
  @invalid_attrs %{name: nil, description: nil, course_id: nil}

  defp create_enrollments(_) do
    enrollments = enrollments_fixture()
    %{enrollments: enrollments}
  end

  describe "Index" do
    setup [:create_enrollments]

    test "lists all enrollments", %{conn: conn, enrollments: enrollments} do
      {:ok, _index_live, html} = live(conn, ~p"/enrollments")

      assert html =~ "Listing Enrollments"
      assert html =~ enrollments.name
    end

    test "saves new enrollments", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/enrollments")

      assert index_live |> element("a", "New Enrollments") |> render_click() =~
               "New Enrollments"

      assert_patch(index_live, ~p"/enrollments/new")

      assert index_live
             |> form("#enrollments-form", enrollments: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#enrollments-form", enrollments: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/enrollments")

      html = render(index_live)
      assert html =~ "Enrollments created successfully"
      assert html =~ "some name"
    end

    test "updates enrollments in listing", %{conn: conn, enrollments: enrollments} do
      {:ok, index_live, _html} = live(conn, ~p"/enrollments")

      assert index_live |> element("#enrollments-#{enrollments.id} a", "Edit") |> render_click() =~
               "Edit Enrollments"

      assert_patch(index_live, ~p"/enrollments/#{enrollments}/edit")

      assert index_live
             |> form("#enrollments-form", enrollments: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#enrollments-form", enrollments: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/enrollments")

      html = render(index_live)
      assert html =~ "Enrollments updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes enrollments in listing", %{conn: conn, enrollments: enrollments} do
      {:ok, index_live, _html} = live(conn, ~p"/enrollments")

      assert index_live |> element("#enrollments-#{enrollments.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#enrollments-#{enrollments.id}")
    end
  end

  describe "Show" do
    setup [:create_enrollments]

    test "displays enrollments", %{conn: conn, enrollments: enrollments} do
      {:ok, _show_live, html} = live(conn, ~p"/enrollments/#{enrollments}")

      assert html =~ "Show Enrollments"
      assert html =~ enrollments.name
    end

    test "updates enrollments within modal", %{conn: conn, enrollments: enrollments} do
      {:ok, show_live, _html} = live(conn, ~p"/enrollments/#{enrollments}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Enrollments"

      assert_patch(show_live, ~p"/enrollments/#{enrollments}/show/edit")

      assert show_live
             |> form("#enrollments-form", enrollments: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#enrollments-form", enrollments: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/enrollments/#{enrollments}")

      html = render(show_live)
      assert html =~ "Enrollments updated successfully"
      assert html =~ "some updated name"
    end
  end
end
