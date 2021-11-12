class PasswordsController < Devise::PasswordsController
  layout 'devise'

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    flash[:alert] = 'Adresse email inconnue!' unless resource.persisted?
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  def update
    super
  end

  protected
  def after_resetting_password_path_for(resource)
    new_session_path(resource_name)
  end
end