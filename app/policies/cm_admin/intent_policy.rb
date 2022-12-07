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