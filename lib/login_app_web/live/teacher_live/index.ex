defmodule LoginAppWeb.TeacherLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School
  alias LoginApp.School.Teacher

  @impl true
  def mount(_params, %{"user_token" => token}, socket) do
    user = LoginApp.Accounts.get_user_by_session_token(token)
    IO.inspect(user.role)
    if user.role == "admin" do
      {:ok, load_teachers(socket, 1)}
    else
    socket =
    socket
    |> put_flash(:error, "Access denied.")
    |> push_navigate(to: "/")
    |> stream(:teachers, []) # Ensure @streams.teacher exists
    {:ok, socket}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Teacher")
    |> assign(:teacher, School.get_teacher!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Teacher")
    |> assign(:teacher, %Teacher{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Teachers")
    |> assign(:teacher, nil)
  end

  @impl true
  def handle_info({LoginAppWeb.TeacherLive.FormComponent, {:saved, teacher}}, socket) do
    {:noreply, stream_insert(socket, :teachers, teacher)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    teacher = School.get_teacher!(id)
    {:ok, _} = School.delete_teacher(teacher)

    {:noreply, stream_delete(socket, :teachers, teacher)}
  end

  @impl true
def handle_event("paginate", %{"page" => page}, socket) do
  {:noreply, load_teachers(socket, String.to_integer(page))}
end


  @spec load_teachers(Phoenix.LiveView.Socket.t(), integer()) :: Phoenix.LiveView.Socket.t()
  defp load_teachers(socket, page) do
    pagination = School.list_teachers_paginated(page: page)

    socket
    |> stream(:teachers, pagination.entries, reset: true)
    |> assign(:pagination, pagination)
    |> assign(:page, page)
  end


end
