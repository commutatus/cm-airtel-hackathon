module CmAdmin::Intent
  extend ActiveSupport::Concern
  included do
    cm_admin do
      actions only: []
      cm_index do
        page_title 'Intents'
        page_description 'Manage all intents here'

        filter [:name], :search, placeholder: 'Search'

        column :name, header: 'Name'
      end

      cm_show page_title: :name, page_description: "Intent Details" do
        tab :profile, '' do
          cm_show_section 'Intent Details' do
            field :name, label: 'Name'
            field :user_id, label: 'User Id'
            field :chatbot_id, label: 'Chatbot Id'
          end
        end
      end

      tab :utterances, 'utterances', associated_model: :utterances, layout_type: 'cm_association_index' do
        column :content, header: 'Content'
      end

      tab :responses, 'responses', associated_model: :responses, layout_type: 'cm_association_index' do
        column :content, header: 'Content'
      end

      cm_new page_title: 'Add Intent', page_description: 'Enter all details to add intent' do
        form_field :name, input_type: :string, label: 'Name'
        form_field :user_id, input_type: :single_select, label: 'User', helper_method: :user_collection
        form_field :chatbot_id, input_type: :single_select, label: 'Chatbot', helper_method: :chatbot_collection
      end

      cm_edit page_title: 'Edit Intent', page_description: 'Edit details of the intent' do
        form_field :name, input_type: :string, label: 'Name'
        form_field :user_id, input_type: :single_select, label: 'User', helper_method: :user_collection
        form_field :chatbot_id, input_type: :single_select, label: 'Chatbot', helper_method: :chatbot_collection
      end
    end
  end
end