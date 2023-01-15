defmodule NervesMetalDetectorWeb.ChartTestLive do
  use NervesMetalDetectorWeb, :live_view

  alias NervesMetalDetector.Inventory
  alias NervesMetalDetectorWeb.UPlotComponent

  @tick_speed 5000

  def render(assigns) do
    ~H"""
    <section>
      <div class="bg-white rounded-lg mb-10 grid gap-2">
        <h2 class="mx-4 mt-2">Single line chart, testing date format</h2>
        <.live_component module={UPlotComponent} id="chart-0" height={120} />

        <h2 class="mx-4 mt-2">Single line chart, getting new data every x seconds</h2>
        <.live_component module={UPlotComponent} id="chart-1" height={120} />

        <h2 class="mx-4 mt-2">
          Single line chart, updating random (also inject) point every x seconds (whole dataset)
        </h2>
        <.live_component module={UPlotComponent} id="chart-2" height={120} />

        <h2 class="mx-4 mt-2">
          Multi line chart, getting new data every x seconds for a random line
        </h2>
        <.live_component module={UPlotComponent} id="chart-3" height={120} />

        <h2 class="mx-4 mt-2">
          Multi line chart, updating random (also inject) point on random line every x seconds
        </h2>
        <.live_component module={UPlotComponent} id="chart-4" height={120} />

        <h2 class="mx-4 mt-2">
          Single line chart, having last datapoint always be the current timestamp, updated every x ms (client side)
        </h2>
        <.live_component module={UPlotComponent} id="chart-5" height={120} live_interval={50} />

        <h2 class="mx-4 mt-2">
          Single line chart, receiving new data before chart is even loaded (client side buffer)
        </h2>
        <.live_component module={UPlotComponent} id="chart-6" height={120} />

        <h2 class="mx-4 mt-2">Multi line chart, formatting the values as currency</h2>
        <.live_component module={UPlotComponent} id="chart-7" height={250} />

        <h2 class="mx-4 mt-2">Single line chart, showing boolean status</h2>
        <.live_component module={UPlotComponent} id="chart-8" height={120} />
      </div>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      send(self(), :load_chart_0)
      send(self(), :load_chart_1)
      send(self(), :load_chart_2)
      send(self(), :load_chart_3)
      send(self(), :load_chart_4)
      send(self(), :load_chart_5)
      send(self(), :load_chart_6)
      send(self(), :load_chart_7)
      send(self(), :load_chart_8)
    end

    {:ok, socket}
  end

  def handle_info(:load_chart_0, socket) do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        now = DateTime.now!("Etc/UTC")

        chart_payload = %{
          data: [
            [
              DateTime.add(now, -800, :day),
              DateTime.add(now, -300, :day),
              DateTime.add(now, -60, :day),
              DateTime.add(now, -20, :day),
              DateTime.add(now, -15, :day),
              DateTime.add(now, -10, :day),
              DateTime.add(now, -5, :day),
              now
            ]
            |> Enum.map(&DateTime.to_unix/1),
            [1, 2, 5, 2, 1, 4, 6, 6]
          ],
          chart_opts: %{
            series: [
              %{},
              %{
                label: "value",
                stroke: Enum.at(colors(), 0)
              }
            ]
          }
        }

        send(pid, {{:chart_loaded, "chart-0"}, chart_payload})
      end)

    {:noreply, socket}
  end

  def handle_info(:load_chart_1, socket) do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        now = DateTime.now!("Etc/UTC")

        chart_payload = %{
          data: [
            [
              DateTime.add(now, -35, :second),
              DateTime.add(now, -30, :second),
              DateTime.add(now, -25, :second),
              DateTime.add(now, -20, :second),
              DateTime.add(now, -15, :second),
              DateTime.add(now, -10, :second),
              DateTime.add(now, -5, :second),
              now
            ]
            |> Enum.map(&DateTime.to_unix/1),
            [1, 2, 5, 2, 1, 4, 6, 6]
          ],
          chart_opts: %{
            series: [
              %{},
              %{
                label: "value",
                stroke: Enum.at(colors(), 0)
              }
            ]
          }
        }

        send(pid, {{:chart_loaded, "chart-1"}, chart_payload})

        {:ok, _task} =
          Task.start(fn ->
            Process.link(pid)

            loop = fn sleep, loop ->
              Process.sleep(sleep)

              data = [
                DateTime.to_unix(DateTime.now!("Etc/UTC")),
                Enum.random(1..6)
              ]

              # new_data_set - normal data
              # new_data_point - %{timestamp: ts, series: "identifier", value: 5}
              send_update(pid, UPlotComponent, id: "chart-1", new_data_set: data)
              loop.(@tick_speed, loop)
            end

            loop.(@tick_speed, loop)
          end)
      end)

    {:noreply, socket}
  end

  def handle_info(:load_chart_2, socket) do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        now = DateTime.now!("Etc/UTC")

        chart_payload = %{
          data: [
            [
              DateTime.add(now, -35, :second),
              DateTime.add(now, -30, :second),
              DateTime.add(now, -25, :second),
              DateTime.add(now, -20, :second),
              DateTime.add(now, -15, :second),
              DateTime.add(now, -10, :second),
              DateTime.add(now, -5, :second),
              now
            ]
            |> Enum.map(&DateTime.to_unix/1),
            [1, 2, 5, 2, 1, 4, 6, 6]
          ],
          chart_opts: %{
            series: [
              %{},
              %{
                label: "value",
                stroke: Enum.at(colors(), 0)
              }
            ]
          }
        }

        send(pid, {{:chart_loaded, "chart-2"}, chart_payload})

        {:ok, _task} =
          Task.start(fn ->
            Process.link(pid)

            loop = fn sleep, loop ->
              Process.sleep(sleep)

              ts =
                Enum.random([
                  DateTime.add(now, -15, :second),
                  DateTime.add(now, -13, :second),
                  DateTime.add(now, -10, :second),
                  DateTime.add(now, -7, :second),
                  DateTime.add(now, -5, :second)
                ])

              data = [
                DateTime.to_unix(ts),
                Enum.random(1..6)
              ]

              send_update(pid, UPlotComponent, id: "chart-2", new_data_set: data)
              loop.(@tick_speed, loop)
            end

            loop.(@tick_speed, loop)
          end)
      end)

    {:noreply, socket}
  end

  def handle_info(:load_chart_3, socket) do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        now = DateTime.now!("Etc/UTC")

        chart_payload = %{
          data: [
            [
              DateTime.add(now, -35, :second),
              DateTime.add(now, -30, :second),
              DateTime.add(now, -25, :second),
              DateTime.add(now, -20, :second),
              DateTime.add(now, -15, :second),
              DateTime.add(now, -10, :second),
              DateTime.add(now, -5, :second),
              now
            ]
            |> Enum.map(&DateTime.to_unix/1),
            [1, 2, 5, 2, 1, 4, 6, 6],
            [6, 5, 2, 5, 6, 2, 1, 1]
          ],
          chart_opts: %{
            series: [
              %{},
              %{
                label: "value 1",
                id: "value_1",
                stroke: Enum.at(colors(), 0)
              },
              %{
                label: "value 2",
                stroke: Enum.at(colors(), 1)
              }
            ]
          }
        }

        send(pid, {{:chart_loaded, "chart-3"}, chart_payload})

        {:ok, _task} =
          Task.start(fn ->
            Process.link(pid)

            loop = fn sleep, loop ->
              Process.sleep(sleep)

              data = %{
                timestamp: DateTime.to_unix(DateTime.now!("Etc/UTC")),
                series: Enum.random(["value_1", "value 2"]),
                value: Enum.random(1..6)
              }

              send_update(pid, UPlotComponent, id: "chart-3", new_data_point: data)
              loop.(@tick_speed, loop)
            end

            loop.(@tick_speed, loop)
          end)
      end)

    {:noreply, socket}
  end

  def handle_info(:load_chart_4, socket) do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        now = DateTime.now!("Etc/UTC")

        chart_payload = %{
          data: [
            [
              DateTime.add(now, -35, :second),
              DateTime.add(now, -30, :second),
              DateTime.add(now, -25, :second),
              DateTime.add(now, -20, :second),
              DateTime.add(now, -15, :second),
              DateTime.add(now, -10, :second),
              DateTime.add(now, -5, :second),
              now
            ]
            |> Enum.map(&DateTime.to_unix/1),
            [1, 2, 5, 2, 1, 4, 6, 6],
            [6, 5, 2, 5, 6, 2, 1, 1]
          ],
          chart_opts: %{
            series: [
              %{},
              %{
                label: "value 1",
                id: "value_1",
                stroke: Enum.at(colors(), 0)
              },
              %{
                label: "value 2",
                stroke: Enum.at(colors(), 1)
              }
            ]
          }
        }

        send(pid, {{:chart_loaded, "chart-4"}, chart_payload})

        {:ok, _task} =
          Task.start(fn ->
            Process.link(pid)

            loop = fn sleep, loop ->
              Process.sleep(sleep)

              ts =
                Enum.random([
                  DateTime.add(now, -15, :second),
                  DateTime.add(now, -13, :second),
                  DateTime.add(now, -10, :second),
                  DateTime.add(now, -7, :second),
                  DateTime.add(now, -5, :second)
                ])

              data = %{
                timestamp: DateTime.to_unix(ts),
                series: Enum.random(["value_1", "value 2"]),
                value: Enum.random(1..6)
              }

              send_update(pid, UPlotComponent, id: "chart-4", new_data_point: data)
              loop.(@tick_speed, loop)
            end

            loop.(@tick_speed, loop)
          end)
      end)

    {:noreply, socket}
  end

  def handle_info(:load_chart_5, socket) do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        now = DateTime.now!("Etc/UTC")

        chart_payload = %{
          data: [
            [
              DateTime.add(now, -35, :second),
              DateTime.add(now, -30, :second),
              DateTime.add(now, -25, :second),
              DateTime.add(now, -20, :second),
              DateTime.add(now, -15, :second),
              DateTime.add(now, -10, :second),
              DateTime.add(now, -5, :second),
              now
            ]
            |> Enum.map(&DateTime.to_unix/1),
            [1, 2, 5, 2, 1, 4, 6, 6]
          ],
          chart_opts: %{
            series: [
              %{},
              %{
                label: "value",
                stroke: Enum.at(colors(), 0)
              }
            ]
          }
        }

        send(pid, {{:chart_loaded, "chart-5"}, chart_payload})

        {:ok, _task} =
          Task.start(fn ->
            Process.link(pid)

            loop = fn sleep, loop ->
              Process.sleep(sleep)

              data = [
                DateTime.to_unix(DateTime.now!("Etc/UTC")),
                Enum.random(1..6)
              ]

              send_update(pid, UPlotComponent, id: "chart-5", new_data_set: data)
              loop.(@tick_speed, loop)
            end

            loop.(@tick_speed, loop)
          end)
      end)

    {:noreply, socket}
  end

  def handle_info(:load_chart_6, socket) do
    pid = self()
    now = DateTime.now!("Etc/UTC")

    {:ok, _task} =
      Task.start_link(fn ->
        Process.sleep(3000)

        chart_payload = %{
          data: [
            [
              DateTime.add(now, -35, :second),
              DateTime.add(now, -25, :second),
              DateTime.add(now, -20, :second),
              DateTime.add(now, -15, :second),
              now
            ]
            |> Enum.map(&DateTime.to_unix/1),
            [1, 5, 2, 1, 6]
          ],
          chart_opts: %{
            series: [
              %{},
              %{
                label: "value",
                stroke: Enum.at(colors(), 0)
              }
            ]
          }
        }

        send(pid, {{:chart_loaded, "chart-6"}, chart_payload})
      end)

    send_update_after(
      pid,
      UPlotComponent,
      [
        id: "chart-6",
        new_data_set: [
          DateTime.to_unix(DateTime.add(now, -30, :second)),
          2
        ]
      ],
      500
    )

    send_update_after(
      pid,
      UPlotComponent,
      [
        id: "chart-6",
        new_data_set: [
          DateTime.to_unix(DateTime.add(now, -10, :second)),
          4
        ]
      ],
      1000
    )

    send_update_after(
      pid,
      UPlotComponent,
      [
        id: "chart-6",
        new_data_set: [
          DateTime.to_unix(DateTime.add(now, -5, :second)),
          6
        ]
      ],
      1500
    )

    send_update_after(
      pid,
      UPlotComponent,
      [
        id: "chart-6",
        new_data_point: %{
          timestamp: DateTime.to_unix(DateTime.add(now, -5, :second)),
          series: "value",
          value: 1
        }
      ],
      2000
    )

    {:noreply, socket}
  end

  def handle_info(:load_chart_7, socket) do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        now = DateTime.now!("Etc/UTC")

        chart_payload = %{
          data: [
            [
              DateTime.add(now, -35, :second),
              DateTime.add(now, -30, :second),
              DateTime.add(now, -25, :second),
              DateTime.add(now, -20, :second),
              DateTime.add(now, -15, :second),
              DateTime.add(now, -10, :second),
              DateTime.add(now, -5, :second),
              now
            ]
            |> Enum.map(&DateTime.to_unix/1),
            [1, 2, 5, 2, 1, 4, 6, 6],
            [56, 57, 57, 57, 57, 57, 57, 57]
            # [55, 55, 55, 56, 56, 56, 57, 57],
          ],
          chart_opts: %{
            series: [
              %{},
              %{
                label: "In Stock",
                scale: "count",
                width: 2,
                stroke: "#93c5fd",
                fill: "#93c5fd4c"
              },
              %{
                label: "Price",
                scale: "price",
                currency: :EUR,
                width: 2,
                stroke: "#eab308",
                dash: [10, 10]
              }
            ],
            axes: [
              %{},
              %{
                scale: "count"
              },
              %{
                side: 1,
                scale: "price",
                grid: %{
                  show: false
                },
                currency: :EUR
              }
            ],
            scales: %{
              count: %{
                range: %{
                  min: %{
                    soft: 0,
                    hard: 0,
                    mode: 1
                  },
                  max: %{}
                }
              },
              price: %{
                range: %{
                  min: %{
                    pad: 1.2,
                    hard: 0,
                    soft: 0
                  },
                  max: %{
                    pad: 1
                  }
                }
              }
            }
          }
        }

        send(pid, {{:chart_loaded, "chart-7"}, chart_payload})
      end)

    {:noreply, socket}
  end

  def handle_info(:load_chart_8, socket) do
    pid = self()

    {:ok, _task} =
      Task.start_link(fn ->
        now = DateTime.now!("Etc/UTC")

        chart_payload = %{
          data: [
            [
              DateTime.add(now, -35, :second),
              DateTime.add(now, -30, :second),
              DateTime.add(now, -25, :second),
              DateTime.add(now, -20, :second),
              DateTime.add(now, -15, :second),
              DateTime.add(now, -10, :second),
              DateTime.add(now, -5, :second),
              now
            ]
            |> Enum.map(&DateTime.to_unix/1),
            [false, nil, true, true, nil, false, true, false]
          ],
          chart_opts: %{
            series: [
              %{},
              %{
                label: "Availability",
                scale: "status",
                value_mapping: %{
                  false => "out of stock",
                  true => "in stock"
                },
                stroke: Enum.at(colors(), 0)
              }
            ],
            axes: [
              %{},
              %{
                scale: "status",
                splits: [false, true],
                values: ["out of stock", "in stock"]
              }
            ]
          }
        }

        send(pid, {{:chart_loaded, "chart-8"}, chart_payload})
      end)

    {:noreply, socket}
  end

  def handle_info({{:chart_loaded, id}, chart_payload}, socket) do
    send_update(UPlotComponent,
      id: id,
      chart_payload: chart_payload
    )

    {:noreply, socket}
  end

  def handle_info(:load_chart_backup, socket) do
    {:ok, task} = Task.start(__MODULE__, :load_chart, [self()])
    monitor = Process.monitor(task)

    {:noreply, socket |> assign(:chart_loading_monitor, monitor)}
  end

  def handle_info({:chart_loaded_backup, chart_payload}, socket) do
    send_update(UPlotComponent,
      id: "chart",
      chart_payload: chart_payload
    )

    {:noreply, socket}
  end

  def handle_info(
        {:DOWN, monitor, :process, _object, reason},
        %{assigns: %{chart_loading_monitor: monitor}} = socket
      ) do
    if reason !== :normal do
      send(self(), :load_chart)
    end

    {:noreply, socket |> assign(:chart_loading_monitor, nil)}
  end

  def load_chart_backup(pid) do
    product_availability_snapshots =
      Inventory.list_product_availability_snapshots(vendor: "berrybasede")

    filtered_snapshots =
      product_availability_snapshots
      |> Enum.group_by(& &1.sku)
      |> Enum.filter(fn {_, list} -> Enum.any?(list, & &1.in_stock) end)

    snapshot_series =
      filtered_snapshots
      |> Enum.map(fn {_, list} -> list end)

    snapshot_skus =
      filtered_snapshots
      |> Enum.map(fn {sku, _} -> sku end)

    timestamps =
      Enum.sort(
        for(series <- snapshot_series, %{fetched_at: t} <- series, uniq: true, do: t),
        DateTime
      )

    now = DateTime.now!("Etc/UTC")

    _first_timestamp =
      now
      |> DateTime.to_date()
      |> Date.add(-14)
      |> DateTime.new!(Time.new!(0, 0, 0))

    timestamps = [] ++ timestamps ++ [now]

    series_data =
      Enum.map(snapshot_series, fn series ->
        mapping = Map.new(series, &{&1.fetched_at, &1.items_in_stock || 0})

        Enum.map(timestamps, &Map.get(mapping, &1))
      end)

    colors = Stream.cycle(colors())

    chart_payload = %{
      chart_opts: %{height: 300},
      data: [Enum.map(timestamps, &DateTime.to_unix/1)] ++ series_data,
      series:
        [%{}] ++
          Enum.map(Enum.with_index(snapshot_skus), fn {sku, index} ->
            %{label: sku, stroke: Enum.at(colors, index)}
          end)
    }

    send(pid, {:chart_loaded, chart_payload})
  end

  defp colors() do
    base_colors = [
      {191, 178, 243},
      {150, 202, 247},
      {156, 220, 170},
      {229, 225, 171},
      {243, 198, 165},
      {248, 163, 168}
    ]

    create_shades = fn {r, g, b} ->
      shades =
        10..50//10
        |> Enum.map(fn n ->
          red = min(r + n, 255)
          green = min(g + n, 255)
          blue = min(b + n, 255)

          "rgb(#{red}, #{green}, #{blue})"
        end)

      ["rgb(#{r}, #{g}, #{b})"] ++ shades
    end

    base_colors
    |> Enum.map(fn base ->
      create_shades.(base)
    end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> List.flatten()
  end
end
