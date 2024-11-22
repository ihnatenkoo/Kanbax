import Config

config :kanbax, Kanbax.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "kanbax",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :kanbax, ecto_repos: [Kanbax.Repo]
