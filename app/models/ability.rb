# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present? && user.teamleader?

    can :manage, Task
    can :manage, TaskPool
  end
end
