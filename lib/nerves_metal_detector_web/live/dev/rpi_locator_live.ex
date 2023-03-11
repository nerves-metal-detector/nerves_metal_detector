defmodule NervesMetalDetectorWeb.Dev.RpiLocatorLive do
  use NervesMetalDetectorWeb, :live_view

  alias NervesMetalDetector.Vendors
  alias NervesMetalDetector.Vendors.Vendor
  alias NervesMetalDetector.Inventory.Data.ProductUpdateItems
  alias NervesMetalDetectorDev.RpiLocator

  @empty_form %{"vendor" => "", "compare" => ""}

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end

  def render(assigns) do
    ~H"""
    <section>
      <div class="bg-white rounded-lg mb-10 p-2 overflow-hidden">
        <h2 class="text-xl pb-2 mb-4 border-b">
          <.link navigate={~p"/dev"} class="hover:text-blue-500">
            Developer Tools
          </.link>
          <.icon name="hero-chevron-right" class={["w-5 h-5"]} /> RpiLocator
        </h2>
        <div :if={@loading_rpilocator_vendors} class="m-4 grid place-content-center">
          <.spinner />
        </div>
        <div :if={!@loading_rpilocator_vendors}>
          <%= case @rpilocator_vendors do %>
            <% {:ok, rpilocator_vendors} -> %>
              <.input_form
                form={@form}
                rpilocator_vendors={rpilocator_vendors}
                nmd_vendors={@nmd_vendors}
              />

              <.intro_message :if={@form.params["vendor"] === ""} />
              <div :if={@loading_items} class="m-4 grid place-content-center">
                <.spinner />
              </div>
              <div :if={@form.params["vendor"] !== "" && !@loading_items}>
                <%= case @items do %>
                  <% {:ok, items} -> %>
                    <div>
                      <%= raw(Makeup.highlight(format_items(items))) %>
                    </div>
                  <% {:error, msg} -> %>
                    <.error_message message={msg} />
                  <% _ -> %>
                    <.fallback_error />
                <% end %>
              </div>
            <% {:error, msg} -> %>
              <.error_message message={msg} />
            <% _ -> %>
              <.fallback_error />
          <% end %>
        </div>
      </div>
    </section>
    """
  end

  def input_form(assigns) do
    ~H"""
    <.form
      for={@form}
      phx-submit="update_selection"
      class="grid md:grid-cols-[240px_max-content_200px_auto] gap-4 items-center mb-4"
    >
      <div class="-mt-1">
        <.input
          field={@form[:vendor]}
          type="select"
          prompt="Select an RpiLocator vendor"
          options={@rpilocator_vendors}
        />
      </div>
      <div>compare to</div>
      <div class="-mt-1">
        <.input
          field={@form[:compare]}
          type="select"
          prompt="Select a NMD vendor"
          options={@nmd_vendors}
        />
      </div>
      <div>
        <.button>Update</.button>
      </div>
    </.form>
    """
  end

  def intro_message(assigns) do
    ~H"""
    <div>
      <p>
        Use this page to load the RpiLocator items for the selected vendor. Additionally, a Nerves Metal Detector vendor can be selected to only show items that do not exist on Nerves Metal Detector. The comparison is done by SKU.
      </p>
      <p class="mt-1">
        RpiLocator has rather aggressive rate limiting. Making too many calls in a short period of time will trigger the limit. Manually visiting rpilocator.com will show an error as well. Simply try again a minute later.
      </p>
    </div>
    """
  end

  def error_message(assigns) do
    ~H"""
    <%= case @message do %>
      <% :rate_limited -> %>
        <div>You got rate limited! Try again in a minute.</div>
      <% msg -> %>
        <div><%= msg %></div>
    <% end %>
    """
  end

  def fallback_error(assigns) do
    ~H"""
    <div>Weird, this should show something, please reload.</div>
    """
  end

  def format_items(items) do
    items =
      Enum.map(items, fn item ->
        %__MODULE__.ProductUpdate{
          url: item.url,
          sku: item.sku
        }
      end)

    items
    |> inspect(pretty: true, limit: :infinity)
    |> String.replace("#{inspect(__MODULE__)}.", "")
  end

  def mount(_params, _session, socket) do
    title = page_title("RpiLocator - Dev Tools")

    meta_attrs = [
      %{name: "title", content: title},
      %{
        name: "description",
        content: "RpiLocator devtools for working on Nerves Metal Detector"
      }
    ]

    nmd_vendors =
      Vendors.all()
      |> Enum.map(fn vendor ->
        {Vendor.display_name(vendor), vendor.id}
      end)

    if connected?(socket) do
      load_rpilocator_vendors()
    end

    socket =
      socket
      |> assign(page_title: title, meta_attrs: meta_attrs)
      |> assign(:form, to_form(@empty_form))
      |> assign(:loading_rpilocator_vendors, true)
      |> assign(:loading_items, false)
      |> assign(:rpilocator_vendors, nil)
      |> assign(:nmd_vendors, nmd_vendors)
      |> assign(:items, nil)

    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    params =
      params
      |> Map.take(Map.keys(@empty_form))
      |> Enum.into(@empty_form)

    socket =
      socket
      |> assign(:form, to_form(params))

    socket =
      if params["vendor"] !== "" do
        if connected?(socket) do
          load_items(params["vendor"], params["compare"])
        end

        assign(socket, :loading_items, true)
      else
        socket
      end

    {:noreply, socket}
  end

  def handle_event("update_selection", params, socket) do
    params = Enum.filter(params, fn {_, v} -> v !== "" end)

    {:noreply, push_patch(socket, to: ~p"/dev/rpilocator?#{params}")}
  end

  def handle_info({:rpilocator_vendors, vendors}, socket) do
    socket =
      socket
      |> assign(:loading_rpilocator_vendors, false)
      |> assign(:rpilocator_vendors, vendors)

    {:noreply, socket}
  end

  def handle_info({:items, items}, socket) do
    socket =
      socket
      |> assign(:loading_items, false)
      |> assign(:items, items)

    {:noreply, socket}
  end

  def load_rpilocator_vendors() do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        vendors = RpiLocator.fetch_vendors()

        send(pid, {:rpilocator_vendors, vendors})
      end)
  end

  def load_items(vendor, compare) do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        items = RpiLocator.fetch_items(vendor)

        items =
          with {:ok, rpilocator_items} <- items,
               nmd_vendor when nmd_vendor not in [nil, ""] <- compare,
               {:ok, nmd_items} <- ProductUpdateItems.get_by_vendor(nmd_vendor) do
            filtered =
              rpilocator_items
              |> Enum.filter(fn %{sku: sku} ->
                !Enum.any?(nmd_items, fn item ->
                  item.sku === sku
                end)
              end)

            {:ok, filtered}
          else
            _ -> items
          end

        send(pid, {:items, items})
      end)
  end
end
