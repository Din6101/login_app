defmodule LoginAppWeb.CoursesLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School
  alias LoginApp.School.Courses

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :courses_collection, School.list_courses())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Courses")
    |> assign(:courses, School.get_courses!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Courses")
    |> assign(:courses, %Courses{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Courses")
    |> assign(:courses, nil)
  end

  @impl true
  def handle_info({LoginAppWeb.CoursesLive.FormComponent, {:saved, courses}}, socket) do
    {:noreply, stream_insert(socket, :courses_collection, courses)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    courses = School.get_courses!(id)
    {:ok, _} = School.delete_courses(courses)

    {:noreply, stream_delete(socket, :courses_collection, courses)}
  end
end
