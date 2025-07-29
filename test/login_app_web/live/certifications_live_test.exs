defmodule LoginAppWeb.CertificationsLiveTest do
  use LoginAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import LoginApp.SchoolFixtures

  @create_attrs %{name: "some name", status: "some status", course_id: "some course_id"}
  @update_attrs %{name: "some updated name", status: "some updated status", course_id: "some updated course_id"}
  @invalid_attrs %{name: nil, status: nil, course_id: nil}

  defp create_certifications(_) do
    certifications = certifications_fixture()
    %{certifications: certifications}
  end

  describe "Index" do
    setup [:create_certifications]

    test "lists all certifications", %{conn: conn, certifications: certifications} do
      {:ok, _index_live, html} = live(conn, ~p"/certifications")

      assert html =~ "Listing Certifications"
      assert html =~ certifications.name
    end

    test "saves new certifications", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/certifications")

      assert index_live |> element("a", "New Certifications") |> render_click() =~
               "New Certifications"

      assert_patch(index_live, ~p"/certifications/new")

      assert index_live
             |> form("#certifications-form", certifications: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#certifications-form", certifications: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/certifications")

      html = render(index_live)
      assert html =~ "Certifications created successfully"
      assert html =~ "some name"
    end

    test "updates certifications in listing", %{conn: conn, certifications: certifications} do
      {:ok, index_live, _html} = live(conn, ~p"/certifications")

      assert index_live |> element("#certifications-#{certifications.id} a", "Edit") |> render_click() =~
               "Edit Certifications"

      assert_patch(index_live, ~p"/certifications/#{certifications}/edit")

      assert index_live
             |> form("#certifications-form", certifications: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#certifications-form", certifications: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/certifications")

      html = render(index_live)
      assert html =~ "Certifications updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes certifications in listing", %{conn: conn, certifications: certifications} do
      {:ok, index_live, _html} = live(conn, ~p"/certifications")

      assert index_live |> element("#certifications-#{certifications.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#certifications-#{certifications.id}")
    end
  end

  describe "Show" do
    setup [:create_certifications]

    test "displays certifications", %{conn: conn, certifications: certifications} do
      {:ok, _show_live, html} = live(conn, ~p"/certifications/#{certifications}")

      assert html =~ "Show Certifications"
      assert html =~ certifications.name
    end

    test "updates certifications within modal", %{conn: conn, certifications: certifications} do
      {:ok, show_live, _html} = live(conn, ~p"/certifications/#{certifications}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Certifications"

      assert_patch(show_live, ~p"/certifications/#{certifications}/show/edit")

      assert show_live
             |> form("#certifications-form", certifications: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#certifications-form", certifications: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/certifications/#{certifications}")

      html = render(show_live)
      assert html =~ "Certifications updated successfully"
      assert html =~ "some updated name"
    end
  end
end
