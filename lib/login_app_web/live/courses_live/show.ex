defmodule LoginAppWeb.CoursesLive.Show do
  use LoginAppWeb, :live_view

  alias LoginApp.School

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:courses, School.get_courses!(id))}
  end

  defp page_title(:show), do: "Show Courses"
  defp page_title(:edit), do: "Edit Courses"
end
