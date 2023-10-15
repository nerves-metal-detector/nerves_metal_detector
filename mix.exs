defmodule NervesMetalDetector.MixProject do
  use Mix.Project

  def project do
    [
      app: :nerves_metal_detector,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {NervesMetalDetector.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.9"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.4", only: :dev},
      {:phoenix_live_view, "~> 0.20.1"},
      {:phoenix_live_dashboard, "~> 0.8.2"},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.9"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.22"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:ecto_psql_extras, "~> 0.7"},
      {:oban, "~> 2.14"},
      {:httpoison, "~> 1.8"},
      {:floki, "~> 0.33.1"},
      {:ex_money, "~> 5.12"},
      {:ex_money_sql, "~> 1.8"},
      {:ex_cldr_dates_times, "~> 2.0"},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:finch, "~> 0.13"},
      {:bandit, ">= 0.6.10"},
      {:plug_canonical_host, "~> 2.0"},
      {:libcluster, "~> 3.3"},
      {:makeup_elixir, "~> 0.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end
end
