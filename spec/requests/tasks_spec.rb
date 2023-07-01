require 'rails_helper'

RSpec.describe TasksController, type: :request do
  let(:user) { create(:user) }
  let(:team_leader) { create(:user, teamleader: true) }
  let(:task_pool) { create(:task_pool) }

  describe "POST #create" do
    context "when user is a team leader" do
      before { sign_in team_leader }

      it "creates a new task" do
        expect {
          post "/tasks", params: { task: { type: "BugReport", title: "New bug report", progress: "to_do", task_pool_id: task_pool.id } }
          expect(response).to redirect_to(root_path)
        }.to change(Task, :count).by(1)
      end
    end

    context "when user is not a team leader" do
      before { sign_in user }

      it "does not create a new task" do
        expect {
          post "/tasks", params: { task: { type: "BugReport", title: "New bug report", description: "A new bug report" } }
        }.not_to change(Task, :count)
      end
    end
  end

  describe "PUT #update" do
    let(:bug_report) { create(:bug_report) }

    context "when user is a team leader" do
      before { sign_in team_leader }

      it "updates the progress of the task" do
        put "/tasks/#{bug_report.id}", params: { bug_report: { progress: "to_do" } }
        expect(bug_report.reload.progress).to eq("to_do")
      end

      it "updates the attachment of the task" do
        put "/tasks/#{bug_report.id}", params: { bug_report: { attachment: fixture_file_upload('attachment.txt', 'text/plain', './spec/fixtures/attachment.txt') } }
        expect(bug_report.reload.attachment).to be_attached
      end
    end

    context "when user is not a team leader" do
      before { sign_in user }

      it "does not update the attachment of the task" do
        put "/tasks/#{bug_report.id}", params: { bug_report: { attachment: fixture_file_upload('attachment.txt', 'text/plain', './spec/fixtures/attachment.txt') } }
        expect(bug_report.reload.attachment).not_to be_attached
      end

      it "redirects to the root path" do
        put "/tasks/#{bug_report.id}", params: { bug_report: { progress: "to_do" } }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:bug_report) { create(:bug_report) }
    let!(:task_pool) { create(:task_pool, tasks: [bug_report]) }

    context "when user is a team leader" do
      before { sign_in team_leader }

      it "destroys the task" do
        expect {
          delete "/tasks/#{bug_report.id}"
        }.to change(Task, :count).by(-1)
      end

      it "redirects to the task pool page" do
        delete "/tasks/#{bug_report.id}"
        expect(response).to redirect_to(task_pool_path(task_pool))
      end
    end

    context "when user is not a team leader" do
      before { sign_in user }
      it "does not destroy the task" do
        expect {
          delete "/tasks/#{bug_report.id}"
        }.not_to change(Task, :count)
      end
    
      it "redirects to the root path" do
        delete "/tasks/#{bug_report.id}"
        expect(response).to redirect_to(root_path)
      end
    end
  
    
  describe "#add_collaborator" do
    let(:task) { create(:task, type: "FeatureRequest") }
    let(:member) { create(:user, teamleader: false) }

    before do
      sign_in team_leader
    end

    it "adds a new user to the task" do
      expect {
        post add_collaborator_task_path(task.id), params: { feature_request: { user_ids: member.id } }
      }.to change { task.users.count }.by(1)
    end

    context "when collaborator is already on the task" do
      before do
        task.users << member
      end

      it "does not add a new user to the task" do
        expect {
          post add_collaborator_task_path(task.id), params: { feature_request: { user_ids: member.id } }
        }.not_to change { task.users.count }
      end

      it "redirects back to the previous page" do
        post add_collaborator_task_path(task.id), params: { feature_request: { user_ids: user.id } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end