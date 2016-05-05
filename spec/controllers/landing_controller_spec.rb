require 'rails_helper'

RSpec.describe LandingController, type: :controller do

  let(:user) { create(:user) }

  describe "GET #index" do
    before do
      sign_in user
    end

    it "returns http success for signed in users" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "redirects visitor to sign in page" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end  

end
