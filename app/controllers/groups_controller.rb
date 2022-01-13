class GroupsController < ApplicationController 
  
  before_action :set_group, only: [:edit, :update, :destroy]

  def index 
    @goups = ContraventionGroup.all
  end

  def new 
    @group = ContraventionGroup.new
  end


  def create 
   @group = ContraventionGroup.new(group_params)
   @group.author_id = current_user 

   if @group.save
     flash[:notice] = "La classe a été créée"
     redirect_to groups_url
   else
    flash[:alert] = @group.errors.full_messages.join(', ')
    render :new 
   end

  end


  def edit 
  end

  def update 
    if @group.update(group_params)
      flash[:notice] = "La classe a été modifiée."
      redirect_to groups_url 
    else
      flash[:alert] = @group.errors.full_messages.joint(', ')
      render :edit
    end
  end 

  def destroy 
    if @group.destroy
       flash[:notice] = "Classe supprimé avec succès"
       redirect_to groups_url
    else
       flash[:alert] = "Impossible de supprimer la Classe"
       redirect_to groups_url
    end
  end

  private 

  def set_group
   @group = ContraventionGroup.find(params[:id])
  end

  def group_params 
    params.require(:contravention_group).permit(:code, :label, :amount, :description)
  end

end