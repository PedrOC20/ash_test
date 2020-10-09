defmodule AshTest.Resources.Tweet do
  use Ash.Resource,
    extensions: [
      AshGraphql.Resource
    ],
    data_layer: AshPostgres.DataLayer

    postgres do
      table "tweets"
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

    attribute :body, :string do
      allow_nil? false
      constraints [max_length: 255]
    end

    # Alternatively, you can use the keyword list syntax
    # You can also set functional defaults, via passing in a zero
    # argument function or an MFA
    attribute :public, :boolean, allow_nil?: false, default: false

    # create_timestamp :created_at #This is set on create
    # update_timestamp :updated_at #This is updated on all updates

    # `create_timestamp` above is just shorthand for:
    # attribute :created_at, :utc_datetime, writable?: false, default: &DateTime.utc_now/0
  end

  relationships do
    belongs_to :user, AshTest.Resources.User,
      source_field: :user_id
  end

  graphql do
    type :tweet

    fields [:id]

    queries do
      get :get_tweet, :default
      list :list_tweets, :default
    end

    mutations do
      create :create_tweet, :default
      update :update_tweet, :default
      destroy :destroy_tweet, :default
    end
  end
end
