module CmAdmin::User
  extend ActiveSupport::Concern
  included do
    cm_admin do
      actions only: []
      cm_index do
        page_title 'Users'
        page_description 'Manage all users here'

        filter [:email], :search, placeholder: 'Search'
        filter :role, :multi_select, collection: ['user', 'admin', 'super_admin'], placeholder: 'Role'

        column :email, header: 'Email'
      end

      cm_show page_title: :email, page_description: "User Details" do
        tab :profile, '' do
          cm_show_section 'User Details' do
            field :email, label: 'Email'
            field :role, label: 'Role', field_type: :enum
          end
        end
      end

      cm_new page_title: 'Add User', page_description: 'Enter all details to add user' do
        form_field :email, input_type: :string, label: 'Email'
        form_field :role, input_type: :single_select, collection: [['User', :user], ['Admin', :admin], ['Super Admin', :super_admin]], label: 'Role'
      end

      cm_edit page_title: 'Edit User', page_description: 'Edit details of the user' do
        form_field :email, input_type: :string, label: 'Email'
        form_field :role, input_type: :single_select, collection: [['User', 0], ['Admin', 1], ['Super Admin', 2]], label: 'Role'
      end
    end
  end
end