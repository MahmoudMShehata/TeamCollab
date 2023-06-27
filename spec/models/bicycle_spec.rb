require "rails_helper"

RSpec.describe Bicycle, type: :model do
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:model) }
    it { is_expected.to validate_presence_of(:style) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  # describe 'attached image' do
  #   subject { FactoryBot.create(:bicycle).image }
  #   it {
  #     is_expected.to be_an_instance_of(ActiveStorage::Attached::One) 
  #   }
  # end
end
