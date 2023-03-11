defmodule NervesMetalDetectorWeb.PaginationComponent do
  use Phoenix.Component
  use NervesMetalDetectorWeb, :verified_routes
  import NervesMetalDetectorWeb.CoreComponents, only: [icon: 1]

  alias Phoenix.LiveView.JS

  attr :page, :integer, required: true
  attr :total_pages, :integer, required: true
  attr :class, :string, default: nil
  attr :jump_to, :any, default: nil
  attr :rest, :global

  def render(assigns) do
    ~H"""
    <div class={["w-fit flex flex-wrap gap-1 items-center", @class]} {@rest}>
      <.link
        :if={@page !== 1}
        patch={"?#{Plug.Conn.Query.encode(%{page: @page - 1})}"}
        phx-click={jump_to(@jump_to)}
        class="bg-blue-300 rounded p-1 text-white hover:bg-blue-500"
      >
        <.icon name="hero-chevron-left" class="w-4 h-4 m-1" />
      </.link>
      <div :if={@page == 1} class="cursor-default bg-slate-200 rounded p-1 text-slate-400">
        <.icon name="hero-chevron-left" class="w-4 h-4 m-1" />
      </div>
      <%= for i <- max(@page - 2 - max(2 - (@total_pages - @page), 0), 1)..min(@page + 2 + max(((2 + 1) - @page), 0), @total_pages) do %>
        <.link
          :if={@page !== i}
          patch={"?#{Plug.Conn.Query.encode(%{page: i})}"}
          phx-click={jump_to(@jump_to)}
          class="bg-blue-300 rounded p-1 min-w-[32px] text-center text-white hover:m-0 hover:bg-blue-500"
        >
          <%= i %>
        </.link>
        <div
          :if={@page == i}
          class="cursor-default bg-blue-500 rounded text-white p-1 min-w-[32px] text-center"
        >
          <%= i %>
        </div>
      <% end %>
      <.link
        :if={@page < @total_pages}
        patch={"?#{Plug.Conn.Query.encode(%{page: @page + 1})}"}
        phx-click={jump_to(@jump_to)}
        class="bg-blue-300 rounded p-1 text-white hover:bg-blue-500"
      >
        <.icon name="hero-chevron-right" class="w-4 h-4 m-1" />
      </.link>
      <div :if={@page >= @total_pages} class="cursor-default bg-slate-200 rounded p-1 text-slate-400">
        <.icon name="hero-chevron-right" class="w-4 h-4 m-1" />
      </div>
    </div>
    """
  end

  defp jump_to(js \\ %JS{}, jump_to) do
    case jump_to do
      nil -> js
      :top -> JS.dispatch("jump-viewport-to", detail: %{top: true})
      id -> JS.dispatch("jump-viewport-to", detail: %{id: id})
    end
  end

  def parse_page(params) when is_map(params) do
    case Integer.parse(params["page"] || "1") do
      {int, _} -> max(int, 1)
      _ -> 1
    end
  end

  def total_pages(item_count, page_size) do
    ceil(item_count / page_size)
  end
end
