module CmAdmin::Utterance
  extend ActiveSupport::Concern
  included do
    cm_admin do
      actions only: []
      visible_on_sidebar false
      cm_index do
        page_title 'Utterances'
        page_description 'Manage all utterances here'

        filter [:content], :search, placeholder: 'Search'

        column :content
      end

      cm_show page_title: :content, page_description: 'Utterance Details' do
        tab :profile, '' do
          cm_show_section 'Utterance Details' do
            field :content
            field :intent_id, label: 'Intent Id'
          end
        end
      end

      cm_new page_title: 'Add Utterance', page_description: 'Enter all details to add utterance' do
        form_field :content, input_type: :string
      end

      cm_edit page_title: 'Edit Utterance', page_description: 'Edit details of the utterance' do
        form_field :content, input_type: :string
      end
    end
  end
end