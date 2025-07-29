defmodule LoginAppWeb.CoursesLive.FormComponent do
  use LoginAppWeb, :live_component

  alias LoginApp.School

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage courses records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="courses-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:course_id]} type="text" label="Course" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Courses</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{courses: courses} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(School.change_courses(courses))
     end)}
  end

  @impl true
  def handle_event("validate", %{"courses" => courses_params}, socket) do
    changeset = School.change_courses(socket.assigns.courses, courses_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"courses" => courses_params}, socket) do
    save_courses(socket, socket.assigns.action, courses_params)
  end

  defp save_courses(socket, :edit, courses_params) do
    case School.update_courses(socket.assigns.courses, courses_params) do
      {:ok, courses} ->
        notify_parent({:saved, courses})

        {:noreply,
         socket
         |> put_flash(:info, "Courses updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_courses(socket, :new, courses_params) do
    case School.create_courses(courses_params) do
      {:ok, courses} ->
        notify_parent({:saved, courses})

        {:noreply,
         socket
         |> put_flash(:info, "Courses created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
