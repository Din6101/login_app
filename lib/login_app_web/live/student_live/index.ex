defmodule LoginAppWeb.StudentLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School
  alias LoginApp.School.Student

  @impl true
  def mount(_params, _session, socket) do
    socket = load_students(socket, 1)
    {:ok, socket}
  end


  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    student = School.get_student!(id)
    {:ok, _} = School.delete_student(student)
    {:noreply, load_students(socket, socket.assigns.page)}
  end

  def handle_event("paginate", %{"page" => page}, socket) do
    {:noreply, load_students(socket, String.to_integer(page))}
  end

  @impl true
  def handle_info({LoginAppWeb.StudentLive.FormComponent, {:saved, student}}, socket) do
    {:noreply, stream_insert(socket, :students, student)}
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

  @spec load_students(Phoenix.LiveView.Socket.t(), integer()) :: Phoenix.LiveView.Socket.t()
defp load_students(socket, page) do
  pagination = School.list_students_paginated(page: page)


  socket
  |> stream(:students, pagination.entries, reset: true)
  |> assign(:pagination, pagination)
  |> assign(:page, page)

end

end
