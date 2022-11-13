module CmAdmin::Response
  extend ActiveSupport::Concern
  included do
    cm_admin do
      actions only: []
      visible_on_sidebar false
      cm_index do
        page_title 'Responses'
        page_description 'Manage all responses here'

        filter [:content], :search, placeholder: 'Search'

        column :content, header: 'Content'
      end

      cm_show page_title: :content, page_description: "Response Details" do
        tab :profile, '' do
          cm_show_section 'Response Details' do
            field :content, label: 'Content'
            field :intent_id, label: 'Intent Id'
          end
        end
      end

      cm_new page_title: 'Add Response', page_description: 'Enter all details to add response' do
        form_field :content, input_type: :string, label: 'Content'
      end

      cm_edit page_title: 'Edit Response', page_description: 'Edit details of the response' do
        form_field :content, input_type: :string, label: 'Content'
        form_field :intent_id, input_type: :single_select, label: 'Intent', helper_method: :intent_collection
      end
    end
  end
end