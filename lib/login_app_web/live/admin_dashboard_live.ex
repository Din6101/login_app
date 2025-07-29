defmodule LoginAppWeb.AdminDashboardLive do
  use LoginAppWeb, :live_view
  alias LoginApp.School
  alias LoginApp.Accounts

  @impl true
  def mount(_params, %{"user_token" => token}, socket) do
    user = Accounts.get_user_by_session_token(token)

    if user.role == "admin" do
      # Example admin dashboard stats
      stats = %{
        teacher_count: School.count_teachers(),
        student_count: School.count_students(),
        user_count: Accounts.count_users()
      }

      {:ok, assign(socket, stats: stats, page_title: "Admin Dashboard")}
    else
      {:ok,
       socket
       |> put_flash(:error, "Access denied.")
       |> redirect(to: "/")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1 class="text-2xl font-bold mb-4"><%= @page_title %></h1>

    <div class="grid grid-cols-3 gap-4">
      <div class="p-4 border rounded shadow">
        <h2 class="text-lg font-semibold">Teachers</h2>
        <p class="text-xl"><%= @stats.teacher_count %></p>
      </div>
      <div class="p-4 border rounded shadow">
        <h2 class="text-lg font-semibold">Students</h2>
        <p class="text-xl"><%= @stats.student_count %></p>
      </div>
      <div class="p-4 border rounded shadow">
        <h2 class="text-lg font-semibold">Users</h2>
        <p class="text-xl"><%= @stats.user_count %></p>
      </div>
    </div>
    """
  end

end
