class NotebooksController < ApplicationController 

  before_action :set_notebook, only: [:edit, :update]
  def index
    @notebooks = ContraventionNotebook.all
    #@profiles_for_user = AdminProfile.order(title: :asc).collect { |p| [p.title, p.id] }
  end  
  def new 
    @notebook = ContraventionNotebook.new
    @groups_for_notebook = ContraventionGroup.order(label: :asc).collect { |g| [g.label, g.id] }
  end 

  def create 
    @notebook = ContraventionNotebook.new(notebook_params)
    @notebook.author_id = current_user
    
    if @notebook.save 
      flash[:notice] = 'Le carnet a été créé.'
      redirect_to notebooks_url
    else
      flash[:alert] = @notebook.errors.full_messages.join(', ')
      render :new
    end
    
  end


  def edit 
    @groups = ContraventionGroup.order(label: :asc).collect { |p| [p.label, p.id] }
  end

  def update

    if @notebook.update(notebook_params)
      flash[:notice] = "Le carnet a été modifié."
      redirect_to notebooks_url 
    else
      flash[:alert] = @notebook.errors.full_messages.joint(', ')
      render :edit
    end


  end




  private

  def set_notebook
    @notebook = ContraventionNotebook.find(params[:id])
  end
  
  def notebook_params 
    params.require(:contravention_notebook).permit(:number, :label, :sheets, :contravention_group_id)
  end
end