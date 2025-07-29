defmodule LoginAppWeb.ResultsLive.FormComponent do
  use LoginAppWeb, :live_component

  alias LoginApp.School

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage results records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="results-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:course_id]} type="text" label="Course" />
        <.input field={@form[:score]} type="text" label="Score" />
        <.input field={@form[:grade]} type="text" label="Grade" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Results</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{results: results} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(School.change_results(results))
     end)}
  end

  @impl true
  def handle_event("validate", %{"results" => results_params}, socket) do
    changeset = School.change_results(socket.assigns.results, results_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"results" => results_params}, socket) do
    save_results(socket, socket.assigns.action, results_params)
  end

  defp save_results(socket, :edit, results_params) do
    case School.update_results(socket.assigns.results, results_params) do
      {:ok, results} ->
        notify_parent({:saved, results})

        {:noreply,
         socket
         |> put_flash(:info, "Results updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_results(socket, :new, results_params) do
    case School.create_results(results_params) do
      {:ok, results} ->
        notify_parent({:saved, results})

        {:noreply,
         socket
         |> put_flash(:info, "Results created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
