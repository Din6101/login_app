defmodule LoginAppWeb.TeacherLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School

  @impl true
def mount(_params, %{"user_token" => token}, socket) do
  user = LoginApp.Accounts.get_user_by_session_token(token)

  if user.role == "admin" do
    {:ok, load_teachers(socket, 1, "", "inserted_at_desc")}

  else
    {:ok,
     socket
     |> put_flash(:error, "Access denied.")
     |> push_navigate(to: "/")
     |> stream(:teachers, [])}
  end
end

  @impl true
def handle_params(params, _url, socket) do
  page = Map.get(params, "page", "1") |> String.to_integer()
  filter = Map.get(params, "filter", "")
  sort = Map.get(params, "sort", "inserted_at_desc")
  # Get teacher for modal (if any)
  teacher =
    case socket.assigns.live_action do
      :edit -> LoginApp.School.get_teacher!(params["id"])
      :new -> %LoginApp.School.Teacher{}
      _ -> nil
    end
  pagination = School.list_teachers_paginated(
    page: page,
    filter: filter,
    sort: sort
  )
  {:noreply,
   socket
   |> assign(:teacher, teacher)
   |> assign(:page_title, page_title(socket.assigns.live_action))
   |> assign(:pagination, pagination)
   |> assign(:filter, filter)
   |> assign(:sort, sort)
   |> stream(:teachers, pagination.entries, reset: true)}
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
    {:noreply, load_teachers(socket, String.to_integer(page), socket.assigns.filter, socket.assigns.sort)}
  end


@impl true
def handle_event("filter", %{"filter" => filter, "sort" => sort}, socket) do
  # Push a patch to re-run handle_params with new query
  {:noreply, push_patch(socket, to: ~p"/teachers?filter=#{filter}&sort=#{sort}")}
end

  @spec load_teachers(Phoenix.LiveView.Socket.t(), integer(), any(), any()) :: Phoenix.LiveView.Socket.t()
  defp load_teachers(socket, page, filter, sort) do
    pagination = School.list_teachers_paginated(page: page, filter: filter, sort: sort)

    socket
    |> stream(:teachers, pagination.entries, reset: true)
    |> assign(:pagination, pagination)
    |> assign(:filter, filter)
    |> assign(:sort, sort)
  end

  defp page_title(:edit), do: "Edit Teacher"
  defp page_title(:new), do: "New Teacher"
  defp page_title(:index), do: "Listing Teachers"


end
