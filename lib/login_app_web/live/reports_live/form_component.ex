defmodule LoginAppWeb.ReportsLive.FormComponent do
  use LoginAppWeb, :live_component

  alias LoginApp.School

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage reports records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="reports-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:course_id]} type="text" label="Course" />
        <.input field={@form[:evaluation]} type="text" label="Evaluation" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Reports</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{reports: reports} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(School.change_reports(reports))
     end)}
  end

  @impl true
  def handle_event("validate", %{"reports" => reports_params}, socket) do
    changeset = School.change_reports(socket.assigns.reports, reports_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"reports" => reports_params}, socket) do
    save_reports(socket, socket.assigns.action, reports_params)
  end

  defp save_reports(socket, :edit, reports_params) do
    case School.update_reports(socket.assigns.reports, reports_params) do
      {:ok, reports} ->
        notify_parent({:saved, reports})

        {:noreply,
         socket
         |> put_flash(:info, "Reports updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_reports(socket, :new, reports_params) do
    case School.create_reports(reports_params) do
      {:ok, reports} ->
        notify_parent({:saved, reports})

        {:noreply,
         socket
         |> put_flash(:info, "Reports created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
