require 'rails_helper'
require 'requests_helper'

RSpec.describe Admin::BicyclesController do
  let(:signed_in_admin) { FactoryBot.create(:admin_user) }

  before do
    @image = fixture_file_upload('spec/fixtures/bike.jpg', 'bike.jpg')
  end

  describe "POST #create" do
    it "creates a new bicycle" do
      params = { bicycle: { model: 'hamada', style: 'hamada brdo', price: 100, image: @image } }
      login_admin(signed_in_admin)
      
      expect { post admin_bicycles_path, params: params }.to change{ Bicycle.count }.by(1)
    end
    
    it "creates a new bicycle with a 'cat' substring in the model name" do
      params = { bicycle: { model: 'catarosky', style: 'off-road', price: 100, image: @image } }
      login_admin(signed_in_admin)
      post admin_bicycles_path, params: params

      expect { post admin_bicycles_path, params: params }.to change{ Bicycle.count }.by(1)
      expect(Bicycle.last.price.to_i).to be >= params[:bicycle][:price]
    end
  end
end
