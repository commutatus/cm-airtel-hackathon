module CmAdmin
  class ApplicationController < ActionController::Base
    include Authentication
    before_action :authenticate_User!
    layout 'cm_admin'
    helper CmAdmin::ViewHelpers
  end
end
