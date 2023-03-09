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
          <.spinner />
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
