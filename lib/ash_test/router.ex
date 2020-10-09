defmodule AshTest.Router do
  use Plug.Router
  import Plug.Conn

  require Logger

  plug(Plug.Logger, log: :debug)

  plug(Corsica, origins: "*")

  plug :match

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason

  plug :dispatch

  # IO.inspect(Code.ensure_compiled(AshTest.Resources.User), label: "TEST")

  forward "/gql",
    to: Absinthe.Plug,
    init_opts: [schema: AshTest.Schema]

  forward "/playground",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [
      schema: AshTest.Schema,
      interface: :playground
    ]

  get "/:email" do
    {:ok, user} = AshTest.Api.get(AshTest.Resources.User, email: email)

    conn
    |> put_resp_content_type("application/json", "utf-8")
    |> send_resp(:ok, user |> Jason.encode!())
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
