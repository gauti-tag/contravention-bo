require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_db_column(:rating).of_type(:float) }
  it { is_expected.to have_db_column(:probability).of_type(:float) }
  it { is_expected.to have_db_column(:payout_rating).of_type(:float) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }

  it "is not valid without attributes" do
    expect(Game.new).to_not be_valid
  end

  describe "Associations" do
    it { should have_many(:game_draws) }
  end

end
