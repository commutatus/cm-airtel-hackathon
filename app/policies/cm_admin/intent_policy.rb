class CmAdmin::IntentPolicy < ApplicationPolicy

  def index?
    true
  end
  
  def show?
    true
  end
  
  def create?
    true
  end
  
  def update?
    true
  end
  
  def destroy?
    true
  end

  def utterances?
    true
  end

  def responses?
    true
  end
  
end