module RequestMacros

  def login_admin
    before(:each) do
      admin = FactoryBot.create(:admin_user)
      sign_in admin
    end
  end

  def login_user
    before(:each) do
      user = FactoryBot.create(:user)
      sign_in user
    end
  end
end