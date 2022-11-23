# frozen_string_literal: true

class Utterance < ApplicationRecord
  include CmAdmin::Utterance
  include AwsLex::Utterance

  belongs_to :intent

  validate :duplicate_utterance

  def duplicate_utterance
    utterances = Utterance.joins(intent: :chatbot).where(chatbot: {id: intent.chatbot_id}).pluck(:content)
    if utterances.include?(content)
      duplicate_intent = Intent.joins(:utterances).where(utterances: {content: content}).pluck(:name).to_sentence
      errors.add :duplicate, "utterance. It must be unique across all intents in the chatbot. The utterance '#{content}' exists in the following intent(s): #{duplicate_intent}. Make sure all of your utterances are unique and try your request again."
    end
  end
end
