class PasswordsController < Devise::PasswordsController
  layout "devise"

  def update
    super
  end

  protected
  def after_resetting_password_path_for(resource)
    new_session_path(resource_name)
  end
end