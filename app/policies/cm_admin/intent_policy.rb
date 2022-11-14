class CmAdmin::IntentPolicy < ApplicationPolicy

  def index?
    true
  end
  
  def update?
    index?
  end
  
  def destroy?
    index?
  end

  def utterances?
    index?
  end

  def responses?
    index?
  end

  class Scope < Scope
    def resolve
      scope.where(user: @user)
      if @user.super_admin?
        scope.all
      else
        scope.where(user: @user)
      end
    end
  end
  
end