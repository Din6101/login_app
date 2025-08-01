defmodule LoginAppWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.
  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use LoginAppWeb, :controller` and
  `use LoginAppWeb, :live_view`.
  """
  use LoginAppWeb, :html

  def mount(_params, _session, socket) do
    {:ok, assign_new(socket, :sidebar_open, fn -> false end)}
  end

  def handle_event("toggle_sidebar", _params, socket) do
    {:noreply, update(socket, :sidebar_open, &(!&1))}
  end


  embed_templates "layouts/*"
end
