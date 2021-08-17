require 'rails_helper'

RSpec.describe AuditLog, type: :model do
  it { is_expected.to have_db_column(:tag).of_type(:integer) }
  it { is_expected.to have_db_column(:module_title).of_type(:string) }
  it { is_expected.to have_db_column(:user_ip).of_type(:string) }
  it { is_expected.to have_db_column(:description).of_type(:text) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }

  it "is not valid without attributes" do
    expect(AuditLog.new).to_not be_valid
  end

  describe '#tag_title' do
    subject(:log) { create(:audit_log) }
    it "return a value" do
      expect(log.tag_title).to_not be_nil
    end
  end
end
