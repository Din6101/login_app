defmodule LoginAppWeb.EnrollmentsLive.FormComponent do
  use LoginAppWeb, :live_component

  alias LoginApp.School

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage enrollments records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="enrollments-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:course_id]} type="text" label="Course" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Enrollments</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{enrollments: enrollments} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(School.change_enrollments(enrollments))
     end)}
  end

  @impl true
  def handle_event("validate", %{"enrollments" => enrollments_params}, socket) do
    changeset = School.change_enrollments(socket.assigns.enrollments, enrollments_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"enrollments" => enrollments_params}, socket) do
    save_enrollments(socket, socket.assigns.action, enrollments_params)
  end

  defp save_enrollments(socket, :edit, enrollments_params) do
    case School.update_enrollments(socket.assigns.enrollments, enrollments_params) do
      {:ok, enrollments} ->
        notify_parent({:saved, enrollments})

        {:noreply,
         socket
         |> put_flash(:info, "Enrollments updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_enrollments(socket, :new, enrollments_params) do
    case School.create_enrollments(enrollments_params) do
      {:ok, enrollments} ->
        notify_parent({:saved, enrollments})

        {:noreply,
         socket
         |> put_flash(:info, "Enrollments created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
