defmodule AshTest.Application do
  use Application

  def start(_type, _args) do
    children = [
      AshTest.Resources.Repo,
      {Plug.Cowboy,
        scheme: :http,
        plug: AshTest.Router,
        options: [port: 4000]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
