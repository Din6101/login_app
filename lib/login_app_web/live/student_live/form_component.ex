defmodule LoginAppWeb.StudentLive.FormComponent do
  use LoginAppWeb, :live_component

  alias LoginApp.School

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage student records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="student-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:users]} type="text" label="Users" />
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:age]} type="number" label="Age" />
        <.input field={@form[:grade]} type="text" label="Grade" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Student</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{student: student} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(School.change_student(student))
     end)}
  end

  @impl true
  def handle_event("validate", %{"student" => student_params}, socket) do
    changeset = School.change_student(socket.assigns.student, student_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"student" => student_params}, socket) do
    save_student(socket, socket.assigns.action, student_params)
  end

  defp save_student(socket, :edit, student_params) do
    case School.update_student(socket.assigns.student, student_params) do
      {:ok, student} ->
        notify_parent({:saved, student})

        {:noreply,
         socket
         |> put_flash(:info, "Student updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_student(socket, :new, student_params) do
    case School.create_student(student_params) do
      {:ok, student} ->
        notify_parent({:saved, student})

        {:noreply,
         socket
         |> put_flash(:info, "Student created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
