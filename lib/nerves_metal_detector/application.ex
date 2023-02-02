defmodule NervesMetalDetector.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies) || []

    children = [
      {Cluster.Supervisor, [topologies, [name: NervesMetalDetector.ClusterSupervisor]]},
      # Start the Telemetry supervisor
      NervesMetalDetectorWeb.Telemetry,
      # Start the Ecto repository
      NervesMetalDetector.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: NervesMetalDetector.PubSub},
      # Start Finch
      {Finch, name: NervesMetalDetector.Finch},
      # Start the Endpoint (http/https)
      NervesMetalDetectorWeb.Endpoint,
      # Start a worker by calling: NervesMetalDetector.Worker.start_link(arg)
      # {NervesMetalDetector.Worker, arg}
      {Oban, Application.fetch_env!(:nerves_metal_detector, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NervesMetalDetector.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NervesMetalDetectorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
