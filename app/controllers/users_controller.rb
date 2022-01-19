class UsersController < ApplicationController
  before_action :fetch_user, only: [:new, :show, :update]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.author = current_user
    @user.account_status = 1
    if @user.save
      flash[:notice] = 'Le compte a été créé.'
      redirect_to users_url
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      @profiles_for_user = AdminProfile.order(title: :asc).collect { |p| [p.title, p.id] }
      render :new
    end
  end

  def show
  end

  def update
    user_attributes = user_params.reject { |_k, v| v.blank? }
    @user.assign_attributes(user_attributes)
    @user.author = current_user
    if @user.save
      flash[:notice] = 'Le compte a été modifié.'
      #redirect_to user_url(@user)
       redirect_to users_path
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      render :show
      
    end
  end

  def update_account_status
    user = User.friendly.find(params[:id])
    status = {
      'active' => 1,
      'suspend' => 2
    }.fetch(params[:status], nil)
    if status.present?
      user.update(account_status: status)
      flash[:notice] = 'Le statut du compte a été modifié.'
    else
      flash[:warning] = "Échèc de l'opération"
    end
    redirect_to users_url
  rescue
    flash[:error] = "Utilisateur inconnu!"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :msisdn, :firstname, :lastname, :password, :password_confirmation, :account_status, :profile_id)
  end

  def fetch_user
    @user = User.friendly.find(params[:id])
  rescue
    @user = User.new
  ensure
    @profiles_for_user = AdminProfile.order(title: :asc).collect { |p| [p.title, p.id] }
  end

end