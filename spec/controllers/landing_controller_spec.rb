require 'rails_helper'

RSpec.describe LandingController, "(HTML)", type: :controller do

  let(:user) { create(:user) }

  context "signed in user" do
    before do
      sign_in user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "visitor" do  
    describe "GET #index" do
      it "redirectsto sign in page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end  
  end

end
