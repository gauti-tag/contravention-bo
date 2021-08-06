class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :has_access_to_current_page?, unless: :devise_controller?
  before_action :set_user_avatar

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :msisdn, :avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
 
  layout :layout_by_resource

  def has_access_to_current_page?
    action_label = params[:action]
    controller_label = params[:controller]
    unless current_user.has_access_to?(controller_label, action_label) == true
      flash[:alert] = 'Accès refusé!'
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

  def set_user_avatar
    @current_avatar = (current_user.avatar.variant(resize: "100x100") rescue '/assets/user.png')
  end

end
