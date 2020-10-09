defmodule AshTest.Resources.User do
  use Ash.Resource,
    extensions: [
      AshGraphql.Resource
    ],
    data_layer: AshPostgres.DataLayer

  @derive {Jason.Encoder, only: [:id, :email]}

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
      writable? true
      default &Ecto.UUID.generate/0
    end

    attribute :email, :string do
      allow_nil? false
      primary_key? false
      constraints [
        match: ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
      ]
    end
  end

  resource do
    identities do
      identity :unique_email, [:email]
    end
  end

  relationships do
    has_many :tweets, AshTest.Resources.Tweet, destination_field: :user_id
  end

  graphql do
    type :user

    fields [:id, :email]

    queries do
      get :get_user, :default
      list :list_users, :default
    end

    mutations do
      create :create_user, :default
      update :update_user, :default
      destroy :destroy_user, :default
    end
  end
end
