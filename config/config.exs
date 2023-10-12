# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :perqara_api,
  ecto_repos: [PerqaraApi.Repo]

# Configures the endpoint
config :perqara_api, PerqaraApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: PerqaraApiWeb.ErrorHTML, json: PerqaraApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PerqaraApi.PubSub,
  live_view: [signing_salt: "unYAOk/c"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :perqara_api, PerqaraApi.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

hammer_expiry_ms =
  System.get_env(
    "HAMMER_EXPIRY_MS",
    "14400000"
  )
  |> String.to_integer()

hammer_cleanup_interval_ms =
  System.get_env(
    "HAMMER_CLEANUP_INTERVAL_MS",
    "600000"
  )
  |> String.to_integer()

config :hammer,
  backend:
    {Hammer.Backend.ETS,
     [expiry_ms: hammer_expiry_ms, cleanup_interval_ms: hammer_cleanup_interval_ms]}

hammer_max_limit_request =
  System.get_env(
    "HAMMER_MAX_LIMIT_REQUEST",
    "5"
  )
  |> String.to_integer()

hammer_bucket_size_in_ms =
  System.get_env(
    "HAMMER_BUCKET_SIZE_IN_MS",
    "60000"
  )
  |> String.to_integer()

config :perqara_api,
  hammer: [
    max_limit_request: hammer_max_limit_request,
    bucket_size_in_ms: hammer_bucket_size_in_ms
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
