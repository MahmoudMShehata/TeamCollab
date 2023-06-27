# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.teamleader?
      can :manage, Task
      can :manage, TaskPool
    end
  end
end
