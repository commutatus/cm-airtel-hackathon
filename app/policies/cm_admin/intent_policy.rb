class CmAdmin::IntentPolicy < ApplicationPolicy

  def index?
    @user.super_admin?
  end
  
  def show?
    @user.super_admin?
  end
  
  def create?
    @user.super_admin?
  end
  
  def update?
    @user.super_admin?
  end
  
  def destroy?
    @user.super_admin?
  end

  def utterances?
    @user.super_admin?
  end

  def responses?
    @user.super_admin?
  end
  
end