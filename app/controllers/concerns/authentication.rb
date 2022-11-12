module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :check_current_User
  end

  private
  def check_current_User
    if current_User
      Current.user = current_User
    end
  end
end