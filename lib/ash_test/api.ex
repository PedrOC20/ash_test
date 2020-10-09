defmodule AshTest.Api do
  use Ash.Api, extensions: [
    AshGraphql.Api
  ]

  graphql do
    authorize? false # Defaults to `true`, use this to disable authorization for the entire API (you probably only want this while prototyping)
  end

  resources do
    resource AshTest.Resources.User
    resource AshTest.Resources.Tweet
  end
end
