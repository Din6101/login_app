defmodule LoginAppWeb.NotificationsLive do
  use LoginAppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Notifications")}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-2xl font-bold">Notifications</h1>
    """
  end
end
