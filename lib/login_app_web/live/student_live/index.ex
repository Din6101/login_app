defmodule LoginAppWeb.StudentLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School

  @impl true
  def mount(_params, _session, socket) do
    socket = load_students(socket, 1)
    {:ok, socket}
  end


  @impl true
  def handle_params(params, _url, socket) do
    page = Map.get(params, "page", "1") |> String.to_integer()
    filter = Map.get(params, "filter", "")
    sort = Map.get(params, "sort", "inserted_at_desc")

    # Get teacher for modal (if any)
    student =
      case socket.assigns.live_action do
        :edit -> LoginApp.School.get_student!(params["id"])
        :new -> %LoginApp.School.Student{}
        _ -> nil
      end

    pagination = School.list_students_paginated(
      page: page,
      filter: filter,
      sort: sort
    )

    {:noreply,
     socket
     |> assign(:student, student)
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pagination, pagination)
     |> assign(:filter, filter)
     |> assign(:sort, sort)
     |> stream(:students, pagination.entries, reset: true)}
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
def handle_event("filter", %{"filter" => query}, socket) do
  page = socket.assigns.pagination.page_number || 1
  sort = socket.assigns.sort || "inserted_at_desc"

  pagination = School.list_students_paginated(
    page: page,
    filter: query,
    sort: sort
  )

  {:noreply,
   socket
   |> assign(:filter, query)
   |> assign(:pagination, pagination)
   |> stream(:students, pagination.entries, reset: true)}
end


  @impl true
  def handle_info({LoginAppWeb.StudentLive.FormComponent, {:saved, student}}, socket) do
    {:noreply, stream_insert(socket, :students, student)}
  end



  @spec load_students(Phoenix.LiveView.Socket.t(), integer()) :: Phoenix.LiveView.Socket.t()
defp load_students(socket, page) do
  pagination = School.list_students_paginated(page: page)


  socket
  |> stream(:students, pagination.entries, reset: true)
  |> assign(:pagination, pagination)
  |> assign(:page, page)
end

  defp page_title(:edit), do: "Edit Student"
  defp page_title(:new), do: "New Student"
  defp page_title(:index), do: "Listing Students"

end
