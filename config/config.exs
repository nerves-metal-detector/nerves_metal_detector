# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :nerves_metal_detector,
  ecto_repos: [NervesMetalDetector.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :nerves_metal_detector, NervesMetalDetectorWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: NervesMetalDetectorWeb.ErrorHTML, json: NervesMetalDetectorWeb.ErrorJSON],
    layout: false
  ],
  adapter: Bandit.PhoenixAdapter,
  pubsub_server: NervesMetalDetector.PubSub,
  live_view: [signing_salt: "B9/Dc+VT"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :nerves_metal_detector, NervesMetalDetector.Mailer, adapter: Swoosh.Adapters.Local

config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
        --config=tailwind.config.js
        --input=css/app.css
        --output=../priv/static/assets/app.css
      ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :nerves_metal_detector, Oban,
  repo: NervesMetalDetector.Repo,
  queues: [default: 1, product_updates: 15],
  plugins: [
    Oban.Plugins.Pruner,
    {Oban.Plugins.Cron,
     crontab: [
       {"0 * * * *", NervesMetalDetector.Jobs.ScheduleProductUpdates}
     ]}
  ]

config :ex_cldr, default_backend: NervesMetalDetector.Cldr

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
