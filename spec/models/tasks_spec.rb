# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task_pool) { create(:task_pool) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  subject do
    described_class.new(
      title: 'Task Title',
      type: 'BugReport',
      description: 'Task description',
      deadline: Time.current + 7.days,
      progress: 'in_progress',
      task_pool: task_pool,
      attachment: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/attachment.txt'), 'text/plain')
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a progress' do
      subject.progress = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:task_pool) }
    it { should have_and_belong_to_many(:users) }
  end

  describe 'assigned to users' do
    it 'can be assigned to multiple users' do
      subject.users << user1
      subject.users << user2
      expect(subject.users.size).to eq(2)
      expect(subject.users).to include(user1, user2)
    end
  end

  describe 'assigned to a task pool' do
    it 'belongs to a task pool' do
      expect(subject.task_pool).to eq(task_pool)
    end

    it 'can be assigned to a different task pool' do
      new_task_pool = create(:task_pool)
      subject.task_pool = new_task_pool
      expect(subject.task_pool).to eq(new_task_pool)
    end
  end
end
