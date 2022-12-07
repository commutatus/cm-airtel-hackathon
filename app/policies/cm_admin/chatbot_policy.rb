class CmAdmin::ChatbotPolicy < ApplicationPolicy

  def index?
    true
  end

  def update?
    index?
  end

  def destroy?
    index?
  end

  def analytics?
    index?
  end

  def build?
    index?
  end

  class Scope < Scope
    def resolve
      if @user.super_admin?
        scope.all
      else
        scope.where(user: @user)
      end
    end
  end

end