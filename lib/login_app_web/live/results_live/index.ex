defmodule LoginAppWeb.ResultsLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School
  alias LoginApp.School.Results

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :results_collection, School.list_results())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Results")
    |> assign(:results, School.get_results!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Results")
    |> assign(:results, %Results{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Results")
    |> assign(:results, nil)
  end

  @impl true
  def handle_info({LoginAppWeb.ResultsLive.FormComponent, {:saved, results}}, socket) do
    {:noreply, stream_insert(socket, :results_collection, results)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    results = School.get_results!(id)
    {:ok, _} = School.delete_results(results)

    {:noreply, stream_delete(socket, :results_collection, results)}
  end
end
