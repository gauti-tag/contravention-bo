class TypesController < ApplicationController 

  before_action :set_type, only: [:edit, :update, :destroy]

  def index 
    @types = ContraventionType.all
  end

  def new 
    @type = ContraventionType.new
    @groups_for_type = ContraventionGroup.order(label: :asc).collect { |g| [g.label, g.id] }
  end


  def create 

    @type = ContraventionType.new(type_params)
    @type.author_id = current_user 

    if @type.save
       flash[:notice] = "Le type a été créé"
       redirect_to types_url
    else
      flash[:alert] = @type.errors.full_messages.join(', ')
      render :new
    end

  end

  def edit
    @groups = ContraventionGroup.order(label: :asc).collect { |p| [p.label, p.id] }
  end

  def update
    if @type.update(type_params)
      flash[:notice] = "Le type a été modifié."
      redirect_to types_url 
    else
      flash[:alert] = @type.errors.full_messages.joint(', ')
      render :edit
    end
  end

  def destroy 
    if @type.destroy
       flash[:notice] = "Type supprimé avec succès"
       redirect_to types_url
    else
       flash[:alert] = "Impossible de supprimer le type"
       redirect_to types_url
    end
  end
  

  private 
  def set_type 
    @type = ContraventionType.find(params[:id])
  end

  def type_params 
    params.require(:contravention_type).permit(:code, :label, :contravention_group_id)
  end

end