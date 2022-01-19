class NotebooksController < ApplicationController 

  before_action :set_notebook, only: [:edit, :update, :destroy]
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

  def destroy 
    if @notebook.destroy
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
            elsif  header == "FEUILLETS"
              header_for_notebook_table[2] = 'sheets'
            elsif  header == "CLASSE"
              header_for_notebook_table[3] = 'contravention_group_id'
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
              group = ContraventionGroup.where(label: type_data['contravention_group_id']).take
              if group
                #flash[:alert] = "#{group.id}"
                group_id = group.id
                type_data['contravention_group_id'] = group_id
                #flash[:alert] = "#{type_data}"
              end

              # if the code type exists update the row
              checking_code = ContraventionNotebook.exists?(number: type_data['number'])
              if checking_code
                  code = ContraventionNotebook.find_by(number: type_data['number'])
                  code.label = type_data['label']
                  code.contravention_group_id = type_data['contravention_group_id']
                  #code.author_id = current_user
                  code.save
              else

                notebook = ContraventionNotebook.new(type_data)
                notebook.save!
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