require 'rails_helper'

RSpec.describe BoardsController, "(JSON API)", type: :controller do

  let(:card) { create(:card, title: "Just a card") }
  let(:list) { create(:list, title: "Some List", cards: [card]) }
  let(:board) { create(:board, title: "Neato", lists: [list]) }
  let(:user) { create(:user, boards: [board]) }
  let!(:another_board) { create(:board) }
  let(:json) { JSON.parse( response.body ) }

  context "Authenticated Users" do
    before do
      sign_in user
    end

    describe "GET /boards" do
      before do
        get :index, format: :json
      end

      it "returns the current user's boards" do
        expect(json[0]["title"]).to eq(board.title)
      end

      it "does not return another user's boards" do
        expect(Board.all.length).to be > 1
        expect(json.length).to eq(1)
      end

      # Board Index is just building a drop down, don't need anything
      # but board title and ID
      # it "also returns all lists associated with each board" do
      #   expect(json[0]["lists"].length).to eq(1)
      # end
    end

    describe "GET /boards/:id" do
      render_views # use jbuilder here, need to render views

      it "returns the board with the :id" do
        get :show, id: board.id, format: :json

        expect(json["title"]).to eq(board.title)
      end

      it "does not return another user's board" do
        get :show, id: another_board.id, format: :json
        
        expect(response).to have_http_status(404)
      end

      it "returns all lists associated with the board" do
        get :show, id: board.id, format: :json

        expect(json["lists"][0]["title"]).to eq(list.title)
      end

      it "returns all cards associated with the board's lists" do
        get :show, id: board.id, format: :json

        expect(json["lists"][0]["cards"][0]["title"]).to eq(card.title)
      end
    end

    describe "POST /boards" do
      it "creates a new board, returns that board" do
        board_data = { format: :json, board: {title: "some title"} }

        expect{ post :create, board_data }.to change(Board, :count).by(1)  
        expect( json["title"] ).to eq("some title")
      end

      it "allows board creation with no attributes/params specified" do
        expect{ post :create, format: :json }.to change(Board, :count).by(1)
      end

      it "sets the current user as a member of the board" do
        expect{ post :create, format: :json }.to change(user.boards, :count).by(1)
      end
    end

    describe "PUT /boards/:id" do
      render_views # use jbuilder here, need to render views

      it "updates an existing board, returns that board" do
        put :update, id: board.id, board: {title: "new title"}, format: :json

        expect(board.reload.title).to eq("new title")
        expect(json["title"]).to eq("new title")
      end

      it "returns 422 if board data is invalid" do
        put :update, id: board.id, board: {title: "a" * 31}, format: :json

        expect(response).to have_http_status(422)
      end

      it "returns 422 if trying to update another user's board" do
        put :update, id: another_board.id, board: {title: "bad user"}, format: :json

        expect(response).to have_http_status(422)
      end

      it "returns all lists associated with the board" do
        put :update, id: board.id, board: {title: "new title"}, format: :json

        expect(json["lists"][0]["title"]).to eq(list.title)
      end

      it "returns all cards associated with the board's lists" do
        put :update, id: board.id, board: {title: "new title"}, format: :json

        expect(json["lists"][0]["cards"][0]["title"]).to eq(card.title)
      end
    end

    describe "DELETE /boards/:id" do
      it "deletes the board" do
        expect{ 
          delete :destroy, id: board.id, format: :json 
        }.to change(Board, :count).by(-1)

        expect(response).to have_http_status(200)
      end
      
      it "doesn't allow deletion of another user's board" do
        expect {
          delete :destroy, id: another_board.id, format: :json
        }.not_to change(Board, :count)

        expect(response).to have_http_status(422)
      end
    end
  end

  context "Unauthenticated Users" do
    describe "GET /boards" do
      it 'returns status of 401' do
        get :index, format: :json

        expect(response).to have_http_status(401)
      end
    end

    describe "GET /boards/:id" do
      it 'returns status of 401' do
        get :show, id: board.id, format: :json

        expect(response).to have_http_status(401)
      end
    end

    describe "POST /boards" do
      it 'returns status of 401' do
        post :create, format: :json

        expect(response).to have_http_status(401)
      end
    end

    describe "PUT /boards/:id" do
      it 'returns status of 401' do
        put :update, id: board.id, board: {title: "nope"}, format: :json

        expect(response).to have_http_status(401)
      end
    end

    describe "DELETE /boards/:id" do
      it 'returns status of 401' do
        delete :destroy, id: board.id, format: :json

        expect(response).to have_http_status(401)
      end
    end
  end

end
