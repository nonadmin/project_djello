require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:board) { build(:board) }

  describe 'relationships' do
    it { is_expected.to have_and_belong_to_many(:members) }
    it { is_expected.to have_many(:lists) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:title).is_at_least(4)
                                                  .is_at_most(30) }
    it { is_expected.to allow_value(nil).for(:title) }
    it "sets title to 'Untitled' if blank" do
      expect(board.title).not_to eq("Untitled")
      board.update(title: "")
      expect(board.reload.title).to eq("Untitled")
    end
  end
end
