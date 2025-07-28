defmodule LoginAppWeb.StudentLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School
  alias LoginApp.School.Student

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :students, School.list_students())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Student")
    |> assign(:student, School.get_student!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Student")
    |> assign(:student, %Student{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Students")
    |> assign(:student, nil)
  end

  @impl true
  def handle_info({LoginAppWeb.StudentLive.FormComponent, {:saved, student}}, socket) do
    {:noreply, stream_insert(socket, :students, student)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    student = School.get_student!(id)
    {:ok, _} = School.delete_student(student)

    {:noreply, stream_delete(socket, :students, student)}
  end
end
