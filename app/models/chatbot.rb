class Chatbot < ApplicationRecord
  include CmAdmin::Chatbot
  belongs_to :user
  has_many :intents

  after_commit :push_to_aws, on [:create, :update]

  validates_format_of :name, with: /\A([a-zA-Z0-9_-]{1,100})\z/, message: 'can have maximum 100 characters. No space is allowed. Valid characters: A–Z, a–z, 0–9, -, _'
  def put_bot_on_aws
    resp = client.put_bot({
      name: "BotName", # required
      description: "Description",
      intents: [
        {
          intent_name: "IntentName", # required
          intent_version: "Version", # required
        },
      ],
      enable_model_improvements: false,
      nlu_intent_confidence_threshold: 1.0,
      clarification_prompt: {
        messages: [ # required
          {
            content_type: "PlainText", # required, accepts PlainText, SSML, CustomPayload
            content: "ContentString", # required
            group_number: 1,
          },
        ],
        max_attempts: 1, # required
        response_card: "ResponseCard",
      },
      abort_statement: {
        messages: [ # required
          {
            content_type: "PlainText", # required, accepts PlainText, SSML, CustomPayload
            content: "ContentString", # required
            group_number: 1,
          },
        ],
        response_card: "ResponseCard",
      },
      idle_session_ttl_in_seconds: 1,
      voice_id: "String",
      checksum: "String",
      process_behavior: "SAVE", # accepts SAVE, BUILD
      locale: "de-DE", # required, accepts de-DE, en-AU, en-GB, en-IN, en-US, es-419, es-ES, es-US, fr-FR, fr-CA, it-IT, ja-JP, ko-KR
      child_directed: false, # required
      detect_sentiment: false,
      create_version: false,
      tags: [
        {
          key: "TagKey", # required
          value: "TagValue", # required
        },
      ],
    })
  end
end
