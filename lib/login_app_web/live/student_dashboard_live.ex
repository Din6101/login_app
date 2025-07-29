defmodule LoginAppWeb.StudentDashboardLive do
  use LoginAppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "User Dashboard")}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-2xl font-bold mb-4">User Dashboard</h1>
    <p>Welcome, User!</p>
    """
  end
end
