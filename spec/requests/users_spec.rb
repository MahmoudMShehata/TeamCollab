# frozen_string_literal: true

RSpec.describe Users::RegistrationsController, type: :request do
  describe 'POST #create' do
    let(:teamleader_params) do
      {
        user: {
          email: 'teamleader@example.com',
          password: 'password',
          password_confirmation: 'password',
          teamleader: 'true'
        }
      }
    end

    let(:non_teamleader_params) do
      {
        user: {
          email: 'non_teamleader@example.com',
          password: 'password',
          password_confirmation: 'password',
          teamleader: 'false'
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new user and sets teamleader to true' do
        expect do
          post user_registration_path, params: teamleader_params
        end.to change(User, :count).by(1)

        expect(response).to redirect_to(user_session_path)
        expect(User.last.teamleader).to eq(true)
      end

      it 'creates a new user and sets teamleader to false' do
        expect do
          post user_registration_path, params: non_teamleader_params
        end.to change(User, :count).by(1)

        expect(response).to redirect_to(user_session_path)
        expect(User.last.teamleader).to eq(false)
      end
    end
  end
end
