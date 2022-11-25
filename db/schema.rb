# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_24_110757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chat_responses", force: :cascade do |t|
    t.json "response"
    t.bigint "chatbot_session_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chatbot_session_id"], name: "index_chat_responses_on_chatbot_session_id"
  end

  create_table "chatbot_sessions", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.bigint "chatbot_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "last_message_at"
    t.string "session_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chatbot_id"], name: "index_chatbot_sessions_on_chatbot_id"
  end

  create_table "chatbots", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "bot_id", comment: "AWS Lex botId value, fetched during the creation from AWS."
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.string "bot_alias_id"
    t.string "locale_id", default: "en_IN"
    t.index ["user_id"], name: "index_chatbots_on_user_id"
  end

  create_table "file_imports", force: :cascade do |t|
    t.string "associated_model_name"
    t.string "added_by_type", null: false
    t.bigint "added_by_id", null: false
    t.jsonb "error_report"
    t.datetime "completed_at"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["added_by_type", "added_by_id"], name: "index_file_imports_on_added_by"
  end

  create_table "intents", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.bigint "chatbot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.string "intent_id", comment: "AWS Lex intentId value, fetched during the creation from AWS."
    t.index ["chatbot_id"], name: "index_intents_on_chatbot_id"
    t.index ["user_id"], name: "index_intents_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "text"
    t.string "from"
    t.string "to"
    t.string "message_id"
    t.string "session_id"
    t.bigint "chatbot_id"
    t.string "intent_name"
    t.bigint "intent_id"
    t.integer "status"
    t.integer "sentiment"
    t.string "sentiment_score"
    t.integer "message_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chatbot_id"], name: "index_messages_on_chatbot_id"
    t.index ["intent_id"], name: "index_messages_on_intent_id"
  end

  create_table "responses", force: :cascade do |t|
    t.text "content"
    t.bigint "intent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["intent_id"], name: "index_responses_on_intent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "utterances", force: :cascade do |t|
    t.text "content"
    t.bigint "intent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["intent_id"], name: "index_utterances_on_intent_id"
  end

  create_table "webhook_events", force: :cascade do |t|
    t.string "source", null: false
    t.json "payload"
    t.string "event_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "business_id"
    t.string "session_id"
    t.index ["business_id"], name: "index_webhook_events_on_business_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chatbots", "users"
  add_foreign_key "intents", "chatbots"
  add_foreign_key "intents", "users"
  add_foreign_key "responses", "intents"
  add_foreign_key "utterances", "intents"
end
