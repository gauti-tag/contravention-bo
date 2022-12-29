class AgentsController < ApplicationController 
 
  before_action :set_agent, only: [:edit, :update, :destroy]

  def index 
    @agents = Agent.all.order(created_at: :desc)
    #respond_to do |format|
    #    format.html
    #    format.csv do 
    #        send_data Agent.to_csv(@agents), filename: "agents_#{Time.now.to_i.to_s}", content_type: 'text/csv'
    #    end
    #end
  end 

  def new 
    @agent = Agent.new 
  end 

  def create
    @agent = Agent.new(agent_params)
    @agent.author_id = current_user.id
    if @agent.save
      api_data = @agent.as_json(root: 'request', only: [:identifier, :last_name, :first_name, :grade])
      api_data['request']['model'] = 'Agent'
      CrudApiManager::InsertData.call(api_data)
      flash[:notice] = "Agent crée avec succès"
      redirect_to agents_url
    else
        if @agent.errors.include?(:same)
            flash[:warning] = 'le N° de grade doit être unique'
            redirect_to agents_url
        else
            flash[:alert] = @agent.errors.full_messages.join(', ')
            redirect_to agents_url
        end
    end
  end

  def edit; end

  def update 
    if @agent.update(agent_params)
      api_data = @agent.as_json(root: 'request', only: [:identifier, :last_name, :first_name, :grade])
      api_data['request']['model'] = 'Agent'
      CrudApiManager::UpdateData.call(api_data)
      flash[:notice] = "Agent modifié avec succès"
      redirect_to agents_url
    else
      flash[:alert] = @agent.errors.full_messages.join(', ')
      redirect_to agents_url
    end
  end

  def destroy
    api_data = @agent.as_json(root: 'request', only: [:identifier])
    api_data['request']['model'] = 'Agent'
    CrudApiManager::DeleteData.call(api_data) 
    if @agent.destroy
      flash[:notice] = "Agent suprimé avec succès"
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

          if headers.length == 2

              headers.each_with_index do |header, idx|
                if  header == "REGION"
                  #header_for_table[0] = 'last_name'
                  header_for_table[0] = 'region'
                elsif  header == "MATRICULE"
                  #header_for_table[1] = 'first_name'
                  header_for_table[1] = 'identifier'
                #elsif  header == "AGENTS"
                #  header_for_table[2] = 'last_name'
                #  header_for_table[3] = 'first_name'
                #elsif  header == "NUMERO_GRADE"
                #  header_for_table[3] = 'identifier'
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
                #  Agent.exists?(identifier: agent_data['identifier'])

                agent_already_saved = Agent.find_by(identifier: agent_data['identifier'])
              
                if agent_already_saved #Agent.exists?(identifier: agent_data['identifier']) 

                    agent_already_saved.update!(agent_data)
                    api_data = agent_already_saved.as_json(root: 'request', only: [:identifier, :last_name, :first_name, :grade])
                    api_data['request']['model'] = 'Agent'
                    CrudApiManager::UpdateData.call(api_data)

                    #Agent.where(identifier: agent_data['identifier']).limit(1).update_all(agent_data)
                else
                    agent = Agent.new(agent_data)
                    agent.author_id = current_user.id
                    agent.save!
                     
                    # Api to save Agent to Core By mass
                    api_data = agent.as_json(root: 'request', only: [:identifier, :last_name, :first_name, :grade])
                    api_data['request']['model'] = 'Agent'
                    CrudApiManager::InsertData.call(api_data)
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
    params.require(:agent).permit(:last_name, :first_name, :grade, :identifier, :region)
  end

end