defmodule NervesMetalDetectorWeb.DevLive do
  use NervesMetalDetectorWeb, :live_view

  def render(assigns) do
    ~H"""
    <section>
      <div class="bg-white rounded-lg mb-10 p-2 overflow-hidden">
        <h2 class="text-xl pb-2 mb-4 border-b">Developer Tools</h2>
        <div class="flex flex-wrap gap-2">
          <.link
            navigate={~p"/dev/dashboard"}
            target="_blank"
            class="p-4 bg-blue-300 rounded text-white hover:bg-blue-500"
          >
            LiveDashboard
          </.link>
          <.link
            navigate={~p"/dev/rpilocator"}
            class="p-4 bg-blue-300 rounded text-white hover:bg-blue-500"
          >
            RpiLocator
          </.link>
        </div>
      </div>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    title = page_title("Dev Tools")

    meta_attrs = [
      %{name: "title", content: title},
      %{
        name: "description",
        content: "Developer tools for working on Nerves Metal Detector"
      }
    ]

    socket =
      socket
      |> assign(page_title: title, meta_attrs: meta_attrs)

    {:ok, socket}
  end
end
