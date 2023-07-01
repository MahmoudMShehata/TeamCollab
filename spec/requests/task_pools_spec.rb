RSpec.describe TaskPoolsController, type: :request do
  let(:user) { create(:user) }
  let(:team_leader) { create(:user, teamleader: true) }
  let(:task_pool) { create(:task_pool, team_leader: team_leader) }
  let(:valid_attributes) { { name: "Test Task Pool" } }
  let(:invalid_attributes) { { name: "" } }

  before do
    sign_in team_leader
  end

  describe "GET #index" do
    it "returns http success" do
      get task_pools_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get task_pool_path(task_pool)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    before do
      ability = Ability.new(user)
      allow(controller).to receive(:current_ability).and_return(ability)
    end

    context "with valid attributes" do
      it "creates a new task pool" do
        post task_pools_path, params: valid_attributes

        expect(TaskPool.last.name).to eq("Test Task Pool")
      end

      it "redirects to the index page" do
        post task_pools_path, params: valid_attributes
        expect(response).to redirect_to(task_pools_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a new task pool" do
        expect {
          post task_pools_path, params: invalid_attributes
        }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      ability = Ability.new(user)
      allow(controller).to receive(:current_ability).and_return(ability)
    end

    context "when the user is the team leader" do
      before do
        task_pool.update(team_leader: user)
      end

      it "destroys the task pool" do
        expect {
          delete task_pool_path(task_pool)
        }.to change(TaskPool, :count).by(-1)
      end

      it "redirects to the index page" do
        delete task_pool_path(task_pool)
        expect(response).to redirect_to(task_pools_path)
      end
    end

    context "when the user is not the team leader" do
      it "does not destroy the task pool" do
        expect {
          delete task_pool_path(task_pool)
        }.not_to change(TaskPool, :count)
      end

      it "redirects to the task pool show page" do
        delete task_pool_path(task_pool)
        expect(response).to redirect_to(task_pools_path)
      end
    end
  end

  describe "POST #add_task" do
    before do
      ability = Ability.new(user)
      allow(controller).to receive(:current_ability).and_return(ability)
    end

    let(:valid_task_attributes) { { title: "Test Task", description: "Test Description", deadline: Date.tomorrow } }
    let(:invalid_task_attributes) { { title: "", description: "", deadline: Date.yesterday } }

    context "when the user is the team leader" do
      before do
        task_pool.update(team_leader: user)
      end

      it "creates a new task with valid attributes" do
        expect {
          post add_task_task_pool_path(task_pool), params: { task: valid_task_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the task pool show page" do
       post add_task_task_pool_path(task_pool), params: { task: valid_task_attributes }
        expect(response).to redirect_to(task_pool_path(task_pool))
      end
    end

    context "when the user is not the team leader" do
      it "does not create a new task" do
        expect {
          post add_task_task_pool_path(task_pool), params: { task: invalid_task_attributes }
        }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Title can't be blank")
      end

      it "redirects to the task pool show page" do
        post add_task_task_pool_path(task_pool), params: { task: valid_task_attributes }
        expect(response).to redirect_to(task_pool_path(task_pool))
      end
    end
  end
end