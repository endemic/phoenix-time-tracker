import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :time_tracker, TimeTracker.Repo,
  database: Path.expand("../time_tracker_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :time_tracker, TimeTrackerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wu/GgefKQ2sw6C1U7qcBgAgEZ7gjFj++KrEPR749mHGgFcTCm4WSLipKE9xmdsPa",
  server: false

# In test we don't send emails.
config :time_tracker, TimeTracker.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
