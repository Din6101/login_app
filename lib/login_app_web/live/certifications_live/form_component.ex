defmodule LoginAppWeb.CertificationsLive.FormComponent do
  use LoginAppWeb, :live_component

  alias LoginApp.School

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage certifications records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="certifications-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:course_id]} type="text" label="Course" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Certifications</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{certifications: certifications} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(School.change_certifications(certifications))
     end)}
  end

  @impl true
  def handle_event("validate", %{"certifications" => certifications_params}, socket) do
    changeset = School.change_certifications(socket.assigns.certifications, certifications_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"certifications" => certifications_params}, socket) do
    save_certifications(socket, socket.assigns.action, certifications_params)
  end

  defp save_certifications(socket, :edit, certifications_params) do
    case School.update_certifications(socket.assigns.certifications, certifications_params) do
      {:ok, certifications} ->
        notify_parent({:saved, certifications})

        {:noreply,
         socket
         |> put_flash(:info, "Certifications updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_certifications(socket, :new, certifications_params) do
    case School.create_certifications(certifications_params) do
      {:ok, certifications} ->
        notify_parent({:saved, certifications})

        {:noreply,
         socket
         |> put_flash(:info, "Certifications created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
