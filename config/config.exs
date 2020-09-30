import Config

config :ash_test, AshTest.Resources.Repo,
  database: System.fetch_env!("DB_DATABASE"),
  username: System.fetch_env!("DB_USERNAME"),
  password: System.fetch_env!("DB_PASSWORD"),
  hostname: System.fetch_env!("DB_HOST")

config :ash_test, ecto_repos: [AshTest.Resources.Repo]
