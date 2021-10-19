require 'rails_helper'

RSpec.describe GameDraw, type: :model do
  it { is_expected.to have_db_column(:balls).of_type(:text) }
  it { is_expected.to have_db_column(:published_at).of_type(:date) }
  it { is_expected.to have_db_column(:drawn_at).of_type(:time) }
  it { is_expected.to have_db_column(:identifier).of_type(:string) }
  it { is_expected.to have_db_column(:game_id).of_type(:integer) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }

  it "is not valid without attributes" do
    expect(GameDraw.new).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:game) }
  end
end
