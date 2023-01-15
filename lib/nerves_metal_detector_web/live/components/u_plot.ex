defmodule NervesMetalDetectorWeb.UPlotComponent do
  use NervesMetalDetectorWeb, :live_component
  import Phoenix.LiveView, only: [push_event: 3]

  def render(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="UPlot"
      phx-update="ignore"
      data-live-interval={@live_interval}
      class="overflow-hidden max-w-full"
    >
      <div
        style={"width: calc(100% - 2rem); height: calc(#{@height}px - 2rem + 29px);"}
        class="m-4 border-4 border-dashed grid place-content-center content-center"
      >
        <div class="grid grid-cols-[minmax(0,_1fr)_auto] gap-2 content-center text-slate-400 font-bold">
          <span>Loading Chart</span>
          <svg
            class="animate-spin mt-0.5 h-5 w-5"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
          >
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4">
            </circle>
            <path
              class="opacity-75"
              fill="currentColor"
              d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
            >
            </path>
          </svg>
        </div>
      </div>
    </div>
    """
  end

  def update(assigns, socket) do
    socket =
      case assigns[:chart_payload] do
        nil ->
          socket

        chart_payload ->
          chart_payload = set_height(chart_payload, assigns, socket)
          push_event(socket, "uPlot:#{assigns.id}:render_chart", %{data: chart_payload})
      end

    socket =
      case assigns[:new_data_set] do
        nil ->
          socket

        new_data_set ->
          push_event(socket, "uPlot:#{assigns.id}:new_data_set", %{data: new_data_set})
      end

    socket =
      case assigns[:new_data_point] do
        nil ->
          socket

        new_data_point ->
          push_event(socket, "uPlot:#{assigns.id}:new_data_point", %{data: new_data_point})
      end

    socket =
      socket
      |> assign(Map.delete(assigns, :chart_payload))
      |> assign(Map.delete(assigns, :new_data_set))
      |> assign(Map.delete(assigns, :new_data_point))
      |> assign_new(:height, fn -> 300 end)
      |> assign_new(:live_interval, fn -> false end)

    {:ok, socket}
  end

  def set_height(chart_payload, assigns, socket) do
    height = assigns[:height] || socket.assigns[:height] || 300
    chart_opts = chart_payload[:chart_opts] || %{}
    Map.put(chart_payload, :chart_opts, Map.put(chart_opts, :height, height))
  end
end
