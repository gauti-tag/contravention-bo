class AdminProfilesController < ApplicationController
  before_action :fetch_profile, only: [:new, :show, :update, :destroy]

  def index
    @profiles = AdminProfile.order(title: :asc)
  end

  def new
  end

  def create
    @profile = AdminProfile.new(profile_params)
    @profile.author = current_user
    if @profile.save
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
    new_abilities = profile_params[:admin_ability_ids]
    new_abilities = new_abilities.collect(&:to_i) if new_abilities.present?
    @profile.title = profile_params[:title]
    @profile.author = current_user
    if @profile.save
      flash[:notice] = 'Le profil a été modifié.'
      unless new_abilities.blank?
        @profile.admin_abilities.delete_all
        @profile.admin_ability_ids = new_abilities
        @profile.save
      end
      redirect_to admin_profile_url(@profile)
    else
      @abilities = {
        'ADMIN' => @abilities.where(tag: :admin),
        'MÉTIER' => @abilities.where(tag: :business),
        'AUTRES' => @abilities.where(tag: :other)
      }
      @profile_abilities = @profile.admin_abilities.pluck(:id)
      flash[:alert] = @user.errors.full_messages.join(', ')
      render :show
    end
  end


  def destroy
    if ['Administrateur', 'Guest'].include? @profile.title.to_s    
        flash[:warning] = 'Impossible de supprimer le profil'
        redirect_to admin_profiles_url
    else 
        if @profile.users.present?
            flash[:warning] = 'Veuillez retirer les utilisateurs utilisant ce profil avant de supprimer'
            redirect_to admin_profiles_url
        else
            @profile.destroy
            flash[:notice] = 'Le profil a été supprimé.'
            redirect_to admin_profiles_url
        end
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