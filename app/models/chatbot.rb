class Chatbot < ApplicationRecord
  include CmAdmin::Chatbot
  belongs_to :user
  has_many :intents
  has_many :chatbot_sessions

  validates_format_of :name, with: /\A([a-zA-Z0-9_-]{1,100})\z/, message: 'can have maximum 100 characters. No space is allowed. Valid characters: A–Z, a–z, 0–9, -, _'
  validates_format_of :description, with: /\A(.{,200})\z/, message: 'can have maximum 200 characters.'

  after_create_commit :create_on_aws
  after_update_commit :update_on_aws
  before_destroy :delete_from_aws

  # Creates an Amazon Lex conversational bot and store the bot_id.
  def create_on_aws
    client = Aws::LexModelsV2::Client.new(
      region: 'ap-southeast-1',
    )

    resp = client.create_bot({
      bot_name: name, # required
      description: description,
      role_arn: Rails.application.credentials.dig(:aws, :lex_role_arn), # required
      data_privacy: { # required
        child_directed: false, # required
      },
      idle_session_ttl_in_seconds: 3600, # required
    })

    update_column('bot_id', resp.bot_id)

    sleep(2)

    create_bot_alias

    create_bot_locale
  end

  # Updates the configuration of an existing bot.
  def update_on_aws
    client = Aws::LexModelsV2::Client.new(
      region: 'ap-southeast-1',
    )

    resp = client.update_bot({
      bot_id: bot_id, # required
      bot_name: name, # required
      description: description,
      role_arn: Rails.application.credentials.dig(:aws, :lex_role_arn), # required
      data_privacy: { # required
        child_directed: false, # required
      },
      idle_session_ttl_in_seconds: 3600, # required
    })
  end

  # Deletes all versions of a bot
  def delete_from_aws
    client = Aws::LexModelsV2::Client.new(
      region: 'ap-southeast-1',
    )

    resp = client.delete_bot({
      bot_id: bot_id, # required
      skip_resource_in_use_check: false,
    })
  end

  # Creates an alias for the specified version of a bot.
  def create_bot_alias
    client = Aws::LexModelsV2::Client.new(
      region: 'ap-southeast-1',
    )

    resp = client.create_bot_alias({
      bot_alias_name: "#{name}_alias", # required
      description: "Bot alias created on #{Rails.env} environment via API by #{Current.user&.email || 'rails console'}",
      sentiment_analysis_settings: {
        detect_sentiment: true, # required
      },
      bot_id: bot_id, # required
    })

    update_column('bot_alias_id', resp.bot_alias_id)
  end

  # Creates a locale in the bot.
  def create_bot_locale
    client = Aws::LexModelsV2::Client.new(
      region: 'ap-southeast-1',
    )

    resp = client.create_bot_locale({
      bot_id: bot_id, # required
      bot_version: 'DRAFT', # required
      locale_id: 'en_IN', # required
      description: 'Bot created on English (India).',
      nlu_intent_confidence_threshold: 0.9, # required
    })
  end
end
