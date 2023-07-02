# frozen_string_literal: true

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:task_pools).with_foreign_key('team_leader_id').dependent(:destroy).inverse_of(:team_leader) }
    it { is_expected.to have_and_belong_to_many(:tasks) }
  end

  describe '#total_tasks_count' do
    let(:task_pool1) { create(:task_pool, team_leader: user) }
    let(:task_pool2) { create(:task_pool, team_leader: user) }
    let!(:task1) { create(:task, task_pool: task_pool1) }
    let!(:task2) { create(:task, task_pool: task_pool1) }
    let!(:task3) { create(:task, task_pool: task_pool2) }

    it 'returns the total number of tasks across all task pools for the user' do
      expect(user.total_tasks_count).to eq(3)
    end
  end

  describe '#overdue_tasks' do
    let(:other_user) { create(:user) }
    let(:task_pool1) { create(:task_pool, team_leader: user) }
    let(:task_pool2) { create(:task_pool, team_leader: other_user) }
    let!(:task1) { create(:task, task_pool: task_pool1, progress: 'in_progress') }
    let!(:task2) { create(:task, task_pool: task_pool2, progress: 'in_progress') }
    let!(:task3) { create(:task, task_pool: task_pool1, progress: 'overdue') }

    it 'returns the tasks that are not done and are either assigned to the user or belong to task pools led by the user' do
      expect(user.overdue_tasks).to contain_exactly(task1, task3)
    end
  end

  describe '#done_tasks' do
    let(:other_user) { create(:user) }
    let(:task_pool1) { create(:task_pool, team_leader: user) }
    let(:task_pool2) { create(:task_pool, team_leader: other_user) }
    let!(:task1) { create(:task, task_pool: task_pool1, progress: 'in_progress') }
    let!(:task2) { create(:task, task_pool: task_pool2, progress: 'done') }
    let!(:task3) { create(:task, task_pool: task_pool1, progress: 'done') }

    it 'returns the tasks that are done and are either assigned to the user or belong to task pools led by the user' do
      expect(user.done_tasks).to contain_exactly(task3)
    end
  end
end
