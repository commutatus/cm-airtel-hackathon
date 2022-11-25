# frozen_string_literal: true

module LexModelsV2
  class Chatbot
    def initialize(bot)
      @bot = bot
      @models_v2_client = Aws::LexModelsV2::Client.new(
        region: 'ap-southeast-1',
      )
    end

    # Creates an Amazon Lex conversational bot and store the bot_id.
    def create_bot
      resp = @models_v2_client.create_bot({
        bot_name: @bot.name, # required
        description: @bot.description,
        role_arn: Rails.application.credentials.dig(:aws, :lex_role_arn), # required
        data_privacy: { # required
          child_directed: false, # required
        },
        idle_session_ttl_in_seconds: 3600, # required
      })

      @bot.update_column('bot_id', resp.bot_id)

      sleep(2)

      create_bot_alias

      create_bot_locale
    end

    # Updates the configuration of an existing bot.
    def update_bot
      @models_v2_client.update_bot({
        bot_id: @bot.bot_id, # required
        bot_name: @bot.name, # required
        description: @bot.description,
        role_arn: Rails.application.credentials.dig(:aws, :lex_role_arn), # required
        data_privacy: { # required
          child_directed: false, # required
        },
        idle_session_ttl_in_seconds: 3600, # required
      })
    end

    # Deletes all versions of a bot
    def delete_bot
      @models_v2_client.delete_bot({
        bot_id: @bot.bot_id, # required
        skip_resource_in_use_check: false,
      })
    end

    # Creates an alias for the specified version of a bot.
    def create_bot_alias
      resp = @models_v2_client.create_bot_alias({
        bot_alias_name: "#{@bot.name.underscore}_alias", # required
        description: "Bot alias created on #{Rails.env} environment via API by #{Current.user&.email || 'rails console'}",
        sentiment_analysis_settings: {
          detect_sentiment: true, # required
        },
        bot_id: @bot.bot_id, # required
      })

      @bot.update_column('bot_alias_id', resp.bot_alias_id)
    end

    # Creates a locale in the bot.
    def create_bot_locale
      @models_v2_client.create_bot_locale({
        bot_id: @bot.bot_id, # required
        bot_version: 'DRAFT', # required
        locale_id: @bot.locale_id, # required
        description: 'Bot created on English (India).',
        nlu_intent_confidence_threshold: 0.9, # required
      })
    end
  end
end
