class UserPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user.present? && scope.where(id: record.id).exists?
  end

  def create?
    user.present? && user.role?(:admin)
  end
  
  def update?
    create?
  end
end