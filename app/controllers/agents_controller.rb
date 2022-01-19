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
        #flash[:notice] = "L'agent a été suprimé"
        flash[:notice] = "L'agent a été suprimé"
        redirect_to agents_url
    else
       flash[:alert] = @agent.errors.full_message.join(', ')
       redirect_to agents_url
    end  
  end


  def import

      data = Agent.open_spreadsheet(params[:file])

        if data == "nok"
          flash[:alert] = "Type de fichier incorrect"
          redirect_to agents_path
        else

          headers = data.row(1)
          header_for_table = []

          if headers.length == 4

              headers.each_with_index do |header, idx|
                if  header == "NOM"
                  header_for_table[0] = 'last_name'
                elsif  header == "PRENOMS"
                  header_for_table[1] = 'first_name'
                elsif  header == "GRADE"
                  header_for_table[2] = 'grade'
                elsif  header == "NUMERO_GRADE"
                  header_for_table[3] = 'identifier'
                else
                  flash[:alert] = "colonnes non conforme"
                end
              end

          else
            flash[:alert] = "fichier non conforme"
          end

          if header_for_table.empty?
            flash[:alert] = "Format de colonne non conforme"
          else
          #flash[:alert] = "#{header_for_table.inspect}"

              data.each_with_index do |row, idx|
                next if idx == 0 #skip header

                #create Hash from headers and cells
                agent_data = Hash[[header_for_table, row].transpose]

                #flash[:alert] = "#{agent_data.inspect}"

                #if the agent exists update the row
                if Agent.exists?(grade: agent_data['grade'])
                    agent_data["author_id"] = current_user
                    Agent.update(agent_data)
                else

                    agent = Agent.new(agent_data)
                    agent["author_id"] = current_user
                    agent.save!

                end


                flash[:notice] = "Importation effectuée avec succès"
              end

          end 
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