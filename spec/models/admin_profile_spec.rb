require 'rails_helper'

RSpec.describe AdminProfile, type: :model do
  # columns
  it { is_expected.to have_db_column(:title).of_type(:string) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }

  it "is not valid without attributes" do
    expect(AdminProfile.new).to_not be_valid
  end


  it "is not valid with a blank title" do
    profile = build(:admin_profile, title: "")
    expect(profile).to_not be_valid
  end
end
