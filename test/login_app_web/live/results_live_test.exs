defmodule LoginAppWeb.ResultsLiveTest do
  use LoginAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import LoginApp.SchoolFixtures

  @create_attrs %{name: "some name", status: "some status", course_id: "some course_id", score: "some score", grade: "some grade"}
  @update_attrs %{name: "some updated name", status: "some updated status", course_id: "some updated course_id", score: "some updated score", grade: "some updated grade"}
  @invalid_attrs %{name: nil, status: nil, course_id: nil, score: nil, grade: nil}

  defp create_results(_) do
    results = results_fixture()
    %{results: results}
  end

  describe "Index" do
    setup [:create_results]

    test "lists all results", %{conn: conn, results: results} do
      {:ok, _index_live, html} = live(conn, ~p"/results")

      assert html =~ "Listing Results"
      assert html =~ results.name
    end

    test "saves new results", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/results")

      assert index_live |> element("a", "New Results") |> render_click() =~
               "New Results"

      assert_patch(index_live, ~p"/results/new")

      assert index_live
             |> form("#results-form", results: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#results-form", results: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/results")

      html = render(index_live)
      assert html =~ "Results created successfully"
      assert html =~ "some name"
    end

    test "updates results in listing", %{conn: conn, results: results} do
      {:ok, index_live, _html} = live(conn, ~p"/results")

      assert index_live |> element("#results-#{results.id} a", "Edit") |> render_click() =~
               "Edit Results"

      assert_patch(index_live, ~p"/results/#{results}/edit")

      assert index_live
             |> form("#results-form", results: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#results-form", results: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/results")

      html = render(index_live)
      assert html =~ "Results updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes results in listing", %{conn: conn, results: results} do
      {:ok, index_live, _html} = live(conn, ~p"/results")

      assert index_live |> element("#results-#{results.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#results-#{results.id}")
    end
  end

  describe "Show" do
    setup [:create_results]

    test "displays results", %{conn: conn, results: results} do
      {:ok, _show_live, html} = live(conn, ~p"/results/#{results}")

      assert html =~ "Show Results"
      assert html =~ results.name
    end

    test "updates results within modal", %{conn: conn, results: results} do
      {:ok, show_live, _html} = live(conn, ~p"/results/#{results}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Results"

      assert_patch(show_live, ~p"/results/#{results}/show/edit")

      assert show_live
             |> form("#results-form", results: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#results-form", results: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/results/#{results}")

      html = render(show_live)
      assert html =~ "Results updated successfully"
      assert html =~ "some updated name"
    end
  end
end
