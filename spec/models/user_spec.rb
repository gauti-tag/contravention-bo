require 'rails_helper'

RSpec.describe User, type: :model do
  # columns
  it { is_expected.to have_db_column(:msisdn).of_type(:string) }
  it { is_expected.to have_db_column(:email).of_type(:string) }
  it { is_expected.to have_db_column(:lastname).of_type(:string) }
  it { is_expected.to have_db_column(:firstname).of_type(:string) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }

  it "is not valid without attributes" do
    expect(User.new).to_not be_valid
  end


  it "is not valid with a blank email" do
    user = build(:user, email: "")
    expect(user).to_not be_valid
  end

  it "is not valid with msisdn like an email address" do
    user = build(:user, email: "admin@test.com", msisdn: "admin@test.com")
    expect(user).to_not be_valid
  end

  it "is not valid with email that not valid" do
    user = build(:user, email: "plainaddress")
    expect(user).to_not be_valid
    another_user = build(:user, email: "#@%^%#$@#$@#.com")
    expect(another_user).to_not be_valid
  end

  describe '#login' do
    subject(:user) { create(:user) }
    it "return a value" do
      expect(user.login).to_not be_nil
    end
  end

  describe '#fullname' do
    subject(:user) { create(:user) }
    it "return a value" do
      expect(user.fullname).to_not be_nil
    end
  end

  describe '#profile_name' do
    subject(:user) { create(:user) }
    it "return a value" do
      expect(user.profile_name).to_not be_nil
    end
  end
end