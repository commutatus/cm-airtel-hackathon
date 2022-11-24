class CmAdmin::FileImportPolicy < ApplicationPolicy

  def index?
    false
  end

  def show?
    index?
  end

end