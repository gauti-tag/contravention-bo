class NotebooksController < ApplicationController 

  before_action :set_notebook, only: [:edit, :update, :destroy]
  def index
    @notebooks = ContraventionNotebook.all.order(created_at: :desc)
    #@profiles_for_user = AdminProfile.order(title: :asc).collect { |p| [p.title, p.id] }
  end  
  def new 
    @notebook = ContraventionNotebook.new
    @groups_for_notebook = ContraventionGroup.order(label: :asc).collect { |g| [g.label, g.id] }
    @agents_for_notebook = Agent.order(last_name: :asc).collect { |a| ["#{a.last_name} #{a.first_name}", a.id] }
  end 

  def create 
    @notebook = ContraventionNotebook.new(notebook_params)
    @notebook.author_id = current_user.id
    
    if @notebook.save 
      api_data = @notebook.as_json(root: 'request', only: [:number, :label, :sheets])
      api_data['request']['model'] = 'ContraventionNotebook' # Defined Model to be used to Core
      api_data['request']['index'] = @notebook.contravention_group.code
      CrudApiManager::InsertData.call(api_data) # Service request to send data to be saved to Core
      flash[:notice] = 'Le carnet a été créé.'
      redirect_to notebooks_url
    else
        if @notebook.errors.include?(:base)
            flash[:warning] = 'le numéro et la classe doivent être uniques!'
            redirect_to new_notebook_url
        else    
            flash[:alert] = @notebook.errors.full_messages.join(', ')
            redirect_to new_notebook_url
        end
     
    end
    
  end


  def edit 
    @groups = ContraventionGroup.order(label: :asc).collect { |p| [p.label, p.id] }
    @agents = Agent.order(last_name: :asc).collect { |a| ["#{a.last_name} #{a.first_name}", a.id] }
  end

  def update
    if @notebook.update(notebook_params)
       api_data = @notebook.as_json(root: 'request', only: [:number, :label, :sheets])
       api_data['request']['model'] = 'ContraventionNotebook'
       api_data['request']['index'] = @notebook.contravention_group.code
       CrudApiManager::UpdateData.call(api_data)
      flash[:notice] = "Le carnet a été modifié."
      redirect_to notebooks_url 
    else
      flash[:alert] = @notebook.errors.full_messages.joint(', ')
      render :edit
    end
  end

  def destroy 
    if @notebook.destroy
       api_data = @notebook.as_json(root: 'request', only: [:number])
       api_data['request']['model'] = 'ContraventionNotebook'
       CrudApiManager::DeleteData.call(api_data)
       flash[:notice] = "Carnet supprimé avec succès"
       redirect_to notebooks_url
    else
       flash[:alert] = "Impossible de supprimer le carnet"
       redirect_to notebooks_url
    end
  end


  def import

    data = ContraventionNotebook.open_spreadsheet(params[:file])

      if data == "nok"
        flash[:alert] = "Format de fichier incorrect"
        redirect_to types_path
      else

        headers = data.row(1)
        header_for_notebook_table = []

        if headers.length == 4

          headers.each_with_index do |header, idx|
            if  header == "NUMERO_CARNET"
              header_for_notebook_table[0] = 'number'
            elsif  header == "LIBELLE_CARNET"
              header_for_notebook_table[1] = 'label'
            elsif  header == "NOMBRE_FEUILLETS"
              header_for_notebook_table[2] = 'sheets'
            elsif  header == "CLASSE"
              header_for_notebook_table[3] = 'contravention_group_id'
           # elsif  header == "AGENT"
           #   header_for_notebook_table[4] = 'agent_id'
            else
              flash[:alert] = "colonnes non conforme"
            end
          end

        else
          flash[:alert] = "fichier non conforme"
        end


        if header_for_notebook_table.empty?
          flash[:alert] = "Format de colonne non conforme"
        else

            data.each_with_index do |row, idx|
              next if idx == 0 #skip header

              #create Hash from headers and cells
            type_data = Hash[[header_for_notebook_table, row].transpose]

              # fetch the corresponding id from the spécifique classe name
              notebook_record = ContraventionGroup.where(label: type_data['contravention_group_id']).take
              if notebook_record

                notebook_record_id = notebook_record.id
                type_data['contravention_group_id'] = notebook_record_id
              else
                flash[:alert] = "la classe << #{type_data['contravention_group_id']} >> à la ligne << #{idx.to_i + 1} >> est inconnue"
                break
              end

            #  notebook_record_agent = Agent.where(identifier: type_data['agent_id']).take

            # if notebook_record_agent

            #    notebook_record_agent_id = notebook_record_agent.id
            #    type_data['agent_id'] = notebook_record_agent_id
            #  else
            #    flash[:alert] = "Agent au matricule << #{type_data['agent_id']} >> à la ligne << #{idx.to_i + 1} >> est inconnu"
            #    break
            #  end

              # if the code type exists update the row
              checking_code = ContraventionNotebook.exists?(number: type_data['number'])
              if checking_code
                  code = ContraventionNotebook.find_by(number: type_data['number'])
                  code.label = type_data['label']
                  code.contravention_group_id = type_data['contravention_group_id']
                  code.save

                  # Request to Core

                  api_data = code.as_json(root: 'request', only: [:number, :label, :sheets])
                  api_data['request']['model'] = 'ContraventionNotebook'
                  api_data['request']['index'] = code.contravention_group.code
                  CrudApiManager::UpdateData.call(api_data)

              else

                notebook = ContraventionNotebook.new(type_data)
                notebook.author_id = current_user.id
                notebook.save
                api_data = notebook.as_json(root: 'request', only: [:number, :label, :sheets])
                api_data['request']['model'] = 'ContraventionNotebook'
                api_data['request']['index'] = notebook.contravention_group.code
                CrudApiManager::InsertData.call(api_data) 
              end


              flash[:notice] = "Importation effectuée avec succès"
            end
        end

       redirect_to notebooks_url

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