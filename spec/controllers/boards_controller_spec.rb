require 'rails_helper'

RSpec.describe BoardsController, "(JSON API)", type: :controller do

  let(:list) { create(:list, title: "Some List") }
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
        expect(Board.all.length).to eq(2)
        expect(json.length).to eq(1)
      end

      # Board Index is just building a drop down, don't need anything
      # but board title and ID
      # it "also returns all lists associated with each board" do
      #   expect(json[0]["lists"].length).to eq(1)
      # end
    end

    describe "GET /boards/:id" do
      it "returns the board with the :id" do
        get :show, id: board.id, format: :json

        expect(json["title"]).to eq(board.title)
      end

      it "does not return another user's board" do
        get :show, id: another_board.id, format: :json
        
        expect(response.body).to eq("null")
      end

      it "also returns all lists associated with the board" do
        get :show, id: board.id, format: :json

        expect(json["lists"][0]["title"]).to eq(list.title)
      end
    end

    describe "POST /boards" do
      it "creates a new board, returns that board" do
        post_data = { format: :json, board: {title: "some title"} }

        expect{ post :create, post_data }.to change(Board, :count).by(1)  
        expect( json["title"] ).to eq("some title")
      end

      it "allows board creation with no attributes/params specified" do
        expect{ post :create, format: :json }.to change(Board, :count).by(1)
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
  end

end
