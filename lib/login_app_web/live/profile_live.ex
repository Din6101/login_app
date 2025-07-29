defmodule LoginAppWeb.ProfileLive do
  use LoginAppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Profile")}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-2xl font-bold">Your Profile!</h1>
    """
  end
end
