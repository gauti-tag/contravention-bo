class PasswordsController < Devise::PasswordsController
  layout 'devise'

  # Find User and him email for resetting his password
  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
        @token = @user.to_sgid(expires_at: Time.now.advance(hours: 1)).to_s
        @url = "#{ENV['APP_URL']}/reset_password/" + @token
        @email_address = [] 
        @email_address << @user.email
        email_template = open("#{Rails.root}/app/views/devise/mailer/reset_password_instructions.html.erb", 'r') { |f| f.read }
        email_content = ERB.new(email_template).result(binding)
        ApiGateway::Email.push(@email_address, ENV['EMAIL_SENDER_OBJECT'].to_s, email_content)
        flash[:notice] = 'Vous allez recevoir sous quelques minutes un email vous indiquant comment réinitialiser votre mot de passe.'
        redirect_to new_user_session_url
    else
        flash[:alert] = 'Adresse email inconnue!'
        redirect_to new_user_password_url
    end
  end
  # Edit User password
  def edit
    @user = User.new
    set_minimum_password_length
    @user.reset_password_token = params[:reset_password_token]
  end
  
  # Update User password
  def update
    user = GlobalID::Locator.locate_signed change_password_params[:reset_password_token]
    if user.nil?
        flash[:alert] = "Le lien pour réinitialiser votre mot de passe est expiré, veuillez en demander un autre"
        redirect_to new_user_session_url
    else
        user.password = change_password_params[:password]
        user.save!
        flash[:notice] = "Votre mot de passe a bien été modifié, Veuillez vous connecter svp!"
        redirect_to new_user_session_url
    end
  end

  protected
  # Params for resetting password
  def change_password_params
    params.require(:user).permit(:reset_password_token, :password, :password_confirmation)
  end

  def after_resetting_password_path_for(resource)
    new_session_path(resource_name)
  end

end