class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    if current_user.is_admin?
      edit_user_registration_path
    else
      # user_root_path
      root_path
    end
  end
end