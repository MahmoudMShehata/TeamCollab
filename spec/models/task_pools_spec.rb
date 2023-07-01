# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskPool, type: :model do
  let(:team_leader) { create(:user) }
  let(:team_member) { create(:user) }

  subject do
    described_class.new(
      name: 'Task Pool Name',
      team_leader: team_leader
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a team leader' do
      subject.team_leader = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:team_leader).class_name('User') }
    it { should have_many(:tasks) }
    it { should have_and_belong_to_many(:team_members).class_name('User').join_table('team_members') }
  end

  describe 'assigned to team members' do
    it 'can be assigned to multiple team members' do
      subject.team_members << team_member
      expect(subject.team_members.size).to eq(1)
      expect(subject.team_members).to include(team_member)
    end
  end
end
