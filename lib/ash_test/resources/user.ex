defmodule AshTest.Resources.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "users"
    repo AshTest.Resources.Repo
  end

  actions do
    create :default
    read :default
    update :default
    destroy :default
  end

  attributes do
    attribute :id, :uuid do
      # All ash resources currently require a primary key
      # Eventually, we will add good defaults and/or allow
      # for a global configuration of your default primary key
      primary_key? true
      allow_nil? false
      writable? false
      default &Ecto.UUID.generate/0
    end

    attribute :email, :string do
      allow_nil? false
      primary_key? true
      constraints [
        match: ~r/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/
      ]
    end

  end

  relationships do
    has_many :tweets, AshTest.Resources.Tweet, destination_field: :user_id
  end
end
