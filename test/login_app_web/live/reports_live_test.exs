defmodule LoginAppWeb.ReportsLiveTest do
  use LoginAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import LoginApp.SchoolFixtures

  @create_attrs %{name: "some name", course_id: "some course_id", evaluation: "some evaluation"}
  @update_attrs %{name: "some updated name", course_id: "some updated course_id", evaluation: "some updated evaluation"}
  @invalid_attrs %{name: nil, course_id: nil, evaluation: nil}

  defp create_reports(_) do
    reports = reports_fixture()
    %{reports: reports}
  end

  describe "Index" do
    setup [:create_reports]

    test "lists all reports", %{conn: conn, reports: reports} do
      {:ok, _index_live, html} = live(conn, ~p"/reports")

      assert html =~ "Listing Reports"
      assert html =~ reports.name
    end

    test "saves new reports", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/reports")

      assert index_live |> element("a", "New Reports") |> render_click() =~
               "New Reports"

      assert_patch(index_live, ~p"/reports/new")

      assert index_live
             |> form("#reports-form", reports: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#reports-form", reports: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/reports")

      html = render(index_live)
      assert html =~ "Reports created successfully"
      assert html =~ "some name"
    end

    test "updates reports in listing", %{conn: conn, reports: reports} do
      {:ok, index_live, _html} = live(conn, ~p"/reports")

      assert index_live |> element("#reports-#{reports.id} a", "Edit") |> render_click() =~
               "Edit Reports"

      assert_patch(index_live, ~p"/reports/#{reports}/edit")

      assert index_live
             |> form("#reports-form", reports: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#reports-form", reports: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/reports")

      html = render(index_live)
      assert html =~ "Reports updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes reports in listing", %{conn: conn, reports: reports} do
      {:ok, index_live, _html} = live(conn, ~p"/reports")

      assert index_live |> element("#reports-#{reports.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#reports-#{reports.id}")
    end
  end

  describe "Show" do
    setup [:create_reports]

    test "displays reports", %{conn: conn, reports: reports} do
      {:ok, _show_live, html} = live(conn, ~p"/reports/#{reports}")

      assert html =~ "Show Reports"
      assert html =~ reports.name
    end

    test "updates reports within modal", %{conn: conn, reports: reports} do
      {:ok, show_live, _html} = live(conn, ~p"/reports/#{reports}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Reports"

      assert_patch(show_live, ~p"/reports/#{reports}/show/edit")

      assert show_live
             |> form("#reports-form", reports: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#reports-form", reports: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/reports/#{reports}")

      html = render(show_live)
      assert html =~ "Reports updated successfully"
      assert html =~ "some updated name"
    end
  end
end
