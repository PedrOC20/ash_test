defmodule AshTest.Resources.Repo do
  use Ecto.Repo,
    otp_app: :ash_test,
    adapter: Ecto.Adapters.Postgres

    # def installed_extensions() do
    #   ["pg_trgm"]
    # end
end
