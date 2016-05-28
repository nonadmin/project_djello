require 'rails_helper'

RSpec.describe ListsController, type: :controller do

  let(:list) { create(:list, title: "Awesome List") }
  let(:board) { create(:board, title: "Listy Board", lists: [list]) }
  let(:user) { create(:user, boards: [board]) }
  let!(:another_list) { create(:list) }
  let(:json) { JSON.parse( response.body ) }

  context "Authenticated Users" do
    before do
      sign_in user
    end

    describe "GET /boards/:id/lists" do
      before do
        get :index, board_id: board.id, format: :json
      end

      it "returns the board's lists" do
        expect(json[0]["title"]).to eq(list.title)
      end

      it "does not return another user's lists" do
        expect(List.all.length).to eq(2)
        expect(json.length).to eq(1)
      end

      it "returns 404 if the board isn't found/not one of the user's boards" do
        get :index, board_id: another_list.board.id, format: :json

        expect(response).to have_http_status(404)
      end
    end

    describe 'POST /boards/:id/lists' do
      it "creates a new list, returns that list" do
        expect {
          post :create, board_id: board.id, format: :json
        }.to change(List, :count).by(1)

        expect(json["board_id"]).to eq(board.id)
      end
    end

    describe 'PUT /boards/:id/lists/:id' do
      it "updates the list, returns the list" do
        put :update, board_id: board.id, id: list.id, 
                     list: {title: "new title"}, format: :json

        expect(list.reload.title).to eq("new title")
        expect(json["title"]).to eq("new title")
      end

      it "returns errors if the updated atrributes are invalid" do
        put :update, board_id: board.id, id: list.id, 
                     list: {title: "a" * 31}, format: :json

        expect(json["title"][0]).to include("too long")
      end

      it "returns 404 if the list isn't found/not one of the board's lists" do
        put :update, board_id: board.id, id: another_list.id, 
                     list: {title: "new title"}, format: :json

        expect(response).to have_http_status(404)        
      end

      it "returns 404 if the board isn't found/not one of the user's boards" do
        put :update, board_id: "zed", id: list.id, 
                     list: {title: "new title"}, format: :json

        expect(response).to have_http_status(404)        
      end      
    end

    describe 'DELETE /boards/:id/lists/:id' do
      it "deletes the list" do
        expect{ 
          delete :destroy, board_id: board.id, id: list.id, format: :json 
        }.to change(List, :count).by(-1)

        expect(response).to have_http_status(204)
      end
      
      it "doesn't allow deletion of another user's list" do
        expect {
          delete :destroy, board_id: board.id, id: another_list.id, format: :json
        }.not_to change(List, :count)

        expect(response).to have_http_status(404)
      end      
    end
  end

  context "Unauthenticated Users" do
    describe "GET /boards/:id/lists" do
      it 'returns status of 401' do
        get :index, board_id: board.id, format: :json

        expect(response).to have_http_status(401)
      end
    end

    describe 'POST /boards/:id/lists' do
      it 'returns status of 401' do
        post :create, board_id: board.id, format: :json

        expect(response).to have_http_status(401)
      end
    end

    describe 'PUT /boards/:id/lists/:id' do
      it 'returns status of 401' do
        put :update, board_id: board.id, id: list.id, 
                     list: {title: "new title"}, format: :json

        expect(response).to have_http_status(401)
      end
    end

    describe 'DELETE /boards/:id/lists/:id' do
      it 'returns status of 401' do
        delete :destroy, board_id: board.id, id: list.id, format: :json

        expect(response).to have_http_status(401)
      end
    end
  end  
end
