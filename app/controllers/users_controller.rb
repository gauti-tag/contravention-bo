class UsersController < ApplicationController
  before_action :fetch_user, only: [:new, :show, :update]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.update(author_id: current_user.id, account_status: 1)
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
    if @user.save
      flash[:notice] = 'Le compte a été modifié.'
      redirect_to user_url(@user)
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :msisdn, :firstname, :lastname, :password, :password_confirmation, :profile_id)
  end

  def fetch_user
    @user = User.friendly.find(params[:id])
  rescue
    @user = User.new
  ensure
    @profiles_for_user = AdminProfile.order(title: :asc).collect { |p| [p.title, p.id] }
  end
  
end