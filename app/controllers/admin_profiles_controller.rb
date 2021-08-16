class AdminProfilesController < ApplicationController
  before_action :fetch_profile, only: [:new, :show, :update]

  def index
    @profiles = AdminProfile.order(title: :asc)
  end

  def new
  end

  def create
    @profile = AdminProfile.new(profile_params)
    if @profile.save
      @profile.update(author_id: current_user.id)
      flash[:notice] = 'Le profil a été créé.'
      redirect_to admin_profiles_url
    else
      flash[:alert] = @profile.errors.full_messages.join(', ')
      @abilities = AdminAbility.order(title: :asc)
      render :new
    end
  end

  def show
    @abilities = {
      'ADMIN' => @abilities.where(tag: :admin),
      'MÉTIER' => @abilities.where(tag: :business),
      'AUTRES' => @abilities.where(tag: :other)
    }
    @profile_abilities = @profile.admin_abilities.pluck(:id)
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

  def profile_params
    params.require(:admin_profile).permit(:title, admin_ability_ids: [])
  end

  def fetch_profile
    @profile = AdminProfile.friendly.find(params[:id])
  rescue
    @profile = AdminProfile.new
  ensure
    @abilities = AdminAbility.order(title: :asc)
  end
  
end