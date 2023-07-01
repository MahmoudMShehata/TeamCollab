RSpec.describe MarketingCampaign, type: :model do
  let(:task_pool) { create(:task_pool) }

  subject {
    described_class.new(
      title: "Marketing Campaign Title",
      description: "Marketing Campaign Description",
      task_pool: task_pool,
      progress: "to_do"
    )
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).not_to be_valid
    end
  end
end
