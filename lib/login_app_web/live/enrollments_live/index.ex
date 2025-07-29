defmodule LoginAppWeb.EnrollmentsLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School
  alias LoginApp.School.Enrollments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :enrollments_collection, School.list_enrollments())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Enrollments")
    |> assign(:enrollments, School.get_enrollments!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Enrollments")
    |> assign(:enrollments, %Enrollments{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Enrollments")
    |> assign(:enrollments, nil)
  end

  @impl true
  def handle_info({LoginAppWeb.EnrollmentsLive.FormComponent, {:saved, enrollments}}, socket) do
    {:noreply, stream_insert(socket, :enrollments_collection, enrollments)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    enrollments = School.get_enrollments!(id)
    {:ok, _} = School.delete_enrollments(enrollments)

    {:noreply, stream_delete(socket, :enrollments_collection, enrollments)}
  end
end
