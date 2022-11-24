module CmAdmin::Chatbot
  extend ActiveSupport::Concern
  included do
    cm_admin do
      actions only: []
      cm_index do
        page_title 'Chatbots'
        page_description 'Manage all chatbots here'

        filter [:name], :search, placeholder: 'Search'

        column :name
        column :description
        column :phone_number, header: 'WhatsApp business number'
      end

      cm_show page_title: :name, page_description: 'Chatbot Details' do
        tab :profile, '' do
          cm_show_section 'Chatbot Details' do
            field :name
            field :description
            field :phone_number, label: 'WhatsApp business number'
          end
        end
      end

      cm_new page_title: 'Add Chatbot', page_description: 'Enter all details to add chatbot' do
        form_field :name, input_type: :string
        form_field :description, input_type: :string
        form_field :phone_number, input_type: :integer, label: 'WhatsApp business number'
        form_field :user_id, input_type: :hidden, helper_method: :user_id
      end

      cm_edit page_title: 'Edit Chatbot', page_description: 'Edit details of the chatbot' do
        form_field :name, input_type: :string
        form_field :description, input_type: :string
        form_field :phone_number, input_type: :integer, label: 'WhatsApp business number'
        form_field :user_id, input_type: :hidden, helper_method: :user_id
      end
    end
  end
end