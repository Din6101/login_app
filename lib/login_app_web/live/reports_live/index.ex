defmodule LoginAppWeb.ReportsLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School
  alias LoginApp.School.Reports

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :reports_collection, School.list_reports())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Reports")
    |> assign(:reports, School.get_reports!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Reports")
    |> assign(:reports, %Reports{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Reports")
    |> assign(:reports, nil)
  end

  @impl true
  def handle_info({LoginAppWeb.ReportsLive.FormComponent, {:saved, reports}}, socket) do
    {:noreply, stream_insert(socket, :reports_collection, reports)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    reports = School.get_reports!(id)
    {:ok, _} = School.delete_reports(reports)

    {:noreply, stream_delete(socket, :reports_collection, reports)}
  end
end
