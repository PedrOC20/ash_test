defmodule AshTest.Api do
  use Ash.Api

  resources do
    resource AshTest.Resources.User
    resource AshTest.Resources.Tweet
  end
end
