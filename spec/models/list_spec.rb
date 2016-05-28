require 'rails_helper'

RSpec.describe List, type: :model do
  let(:list) { build(:list) }

  describe 'relationships' do
    it { is_expected.to belong_to(:board) }
    it { is_expected.to have_many(:cards) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:title).is_at_least(4)
                                                  .is_at_most(16) }
    it { is_expected.to allow_value(nil).for(:title) }
    it { is_expected.to validate_length_of(:description).is_at_least(10)
                                                        .is_at_most(512) }
    it { is_expected.to allow_value(nil).for(:description) }
  end
end
