class AgentsController < ApplicationController 
 
  before_action :set_agent, only: [:edit, :update, :destroy]

  def index 
    @agents = Agent.all
  end 

  def new 
    @agent = Agent.new 
  end 

  def create 
    @agent = Agent.new(agent_params)
    @agent.author_id = current_user

    if @agent.save
       flash[:notice] = "L'agent a été cré"
       redirect_to agents_url
    else
      flash[:alert] = @agent.errors.full_messages.join(', ')
      render :new 
    end
  end

  def edit 

  end

  def update 
    if @agent.update(agent_params)
      flash[:notice] = "L'agent a été modifié"
      redirect_to agents_url
    else
      flash[:alert] = @agent.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy 
    if @agent.destroy 
        flash[:notice] = "L'agent a été suprimé"
        redirect_to agents_url
    else
       flash[:alert] = @agent.errors.full_message.join(', ')
       redirect_to agents_url
    end  
  end


  private 
  def set_agent 
   @agent = Agent.find(params[:id])
  end

  def agent_params 
    params.require(:agent).permit(:last_name, :first_name, :grade, :identifier)
  end

end