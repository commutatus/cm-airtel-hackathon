module CmAdmin::Intent
  extend ActiveSupport::Concern
  included do
    cm_admin do
      actions only: []
      cm_index do
        page_title 'Intents'
        page_description 'Manage all intents here'

        filter [:name], :search, placeholder: 'Search'

        column :name
        column :description
        column :name, header: 'Chatbot', field_type: :association, association_name: :chatbot, association_type: :belongs_to
      end

      cm_show page_title: :name, page_description: 'Intent Details' do
        tab :profile, '' do
          cm_show_section 'Intent Details' do
            field :name
            field :description
            field :user_id, label: 'User Id'
            field :name, label: 'Chatbot', field_type: :association, association_name: :chatbot, association_type: :belongs_to
          end
        end

        custom_action name: 'build', route_type: 'member', verb: 'post', path: ':id/build',
                      display_type: :button do |intent|
          intent.chatbot.build
          intent
        end
      end

      tab :utterances, 'utterances', associated_model: :utterances, layout_type: 'cm_association_index', display_if: -> (obj) { obj.custom? } do
        column :content, header: 'Content'
      end

      tab :responses, 'responses', associated_model: :responses, layout_type: 'cm_association_index' do
        column :content
      end

      cm_new page_title: 'Add Intent', page_description: 'Enter all details to add intent' do
        form_field :name, input_type: :string
        form_field :description, input_type: :string
        form_field :user_id, input_type: :hidden, helper_method: :user_id
        form_field :chatbot_id, input_type: :single_select, label: 'Chatbot', helper_method: :chatbot_collection
      end

      cm_edit page_title: 'Edit Intent', page_description: 'Edit details of the intent' do
        form_field :name, input_type: :string
        form_field :description, input_type: :string
        form_field :user_id, input_type: :hidden, helper_method: :user_id
        form_field :chatbot_id, input_type: :single_select, label: 'Chatbot', helper_method: :chatbot_collection
      end
    end
  end
end