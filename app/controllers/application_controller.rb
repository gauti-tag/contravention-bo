class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :access_to_page?, unless: :devise_controller?

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :msisdn, :firstname, :lastname, :avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
 
  layout :layout_by_resource

  def access_to_page?
    action_label = params[:action]
    controller_label = params[:controller]
    action_label = params[:model_name] if controller_label == 'loto' && action_label == 'transactions'
    unless current_user.access_to?(controller_label, action_label) == true
      flash[:warning] = 'Accès refusé!'
      redirect_to edit_user_registration_url, status: 301
    end
  end

  private

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      'devise'
    else
      'application'
    end
  end

  def after_sign_in_path_for(resource)
    if resource.active?
      AuditLog.create(module_title: 'Utilisateurs', user_id: resource.id, description: "Connexion", user_ip: current_user.current_sign_in_ip)
      resource.home_path
    else
      flash[:alert] = 'Désolé votre compte a été suspendu!'
      AuditLog.create(module_title: 'Utilisateurs', user_id: resource.id, description: "Connexion", user_ip: current_user.current_sign_in_ip, tag: 2)
      sign_out :user
      new_user_session_path
    end
  end

end
