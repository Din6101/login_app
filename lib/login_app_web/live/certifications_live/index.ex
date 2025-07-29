defmodule LoginAppWeb.CertificationsLive.Index do
  use LoginAppWeb, :live_view

  alias LoginApp.School
  alias LoginApp.School.Certifications

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :certifications_collection, School.list_certifications())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Certifications")
    |> assign(:certifications, School.get_certifications!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Certifications")
    |> assign(:certifications, %Certifications{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Certifications")
    |> assign(:certifications, nil)
  end

  @impl true
  def handle_info({LoginAppWeb.CertificationsLive.FormComponent, {:saved, certifications}}, socket) do
    {:noreply, stream_insert(socket, :certifications_collection, certifications)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    certifications = School.get_certifications!(id)
    {:ok, _} = School.delete_certifications(certifications)

    {:noreply, stream_delete(socket, :certifications_collection, certifications)}
  end
end
