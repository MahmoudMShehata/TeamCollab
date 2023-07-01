# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ability, type: :model do
  let(:user) { create(:user) }
  let(:team_leader) { create(:user, teamleader: true) }
  let(:task) { create(:task) }
  let(:task_pool) { create(:task_pool, team_leader: team_leader) }

  describe 'team leader ability' do
    subject(:ability) { Ability.new(team_leader) }

    it 'can manage tasks' do
      expect(ability.can?(:manage, task)).to be true
    end

    it 'can manage task pools' do
      expect(ability.can?(:manage, task_pool)).to be true
    end
  end

  describe 'regular user ability' do
    subject(:ability) { Ability.new(user) }

    it 'cannot manage tasks' do
      expect(ability.can?(:manage, task)).to be false
    end

    it 'cannot manage task pools' do
      expect(ability.can?(:manage, task_pool)).to be false
    end
  end
end
