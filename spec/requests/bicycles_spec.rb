require 'rails_helper'
require 'requests_helper'

RSpec.describe BicyclesController, type: :request do
  let(:signed_in_user) { FactoryBot.create(:user) }
  let(:choosen_bicycle) { FactoryBot.create(:bicycle) }

  describe 'GET #index' do
    it 'returns all bicycles' do
      @bicycles = [FactoryBot.build_stubbed(:bicycle)]
      allow(Bicycle).to receive(:all).and_return(@bicycles)
      login(signed_in_user)

      get bicycles_path

      expect(response).to be_successful
      expect(assigns(:bicycles)).to match_array(@bicycles)
    end
  end

  describe 'GET #show' do
    it 'returns a selected bicycle' do
      login(signed_in_user)
      get "/bicycles/#{choosen_bicycle.id}"

      expect(response).to be_successful
    end
  end
end