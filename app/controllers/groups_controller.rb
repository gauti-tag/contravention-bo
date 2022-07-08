class GroupsController < ApplicationController

  before_action :set_group, only: [:edit, :update, :destroy]

  def index
    @goups = ContraventionGroup.all.order(created_at: :desc)
  end

  def new
    @group = ContraventionGroup.new
  end


  def create
   @group = ContraventionGroup.new(group_params)
   @group.author_id = current_user.id
   if @group.save
     api_data = @group.as_json(root: 'request', only: [:code, :label, :description])
     api_data['request']['model'] = 'ContraventionGroup'
     CrudApiManager::InsertData.call(api_data) # Service Request to send values to be saved to core
     flash[:notice] = "La classe a été créée"
     redirect_to groups_url
   else
    flash[:alert] = @group.errors.full_messages.join(', ')
    render :new 
   end

  end


  def edit; end

  def update 
      if @group.update(group_params)
        api_data = @group.as_json(root: 'request', only: [:code, :label, :description])
        api_data['request']['model'] = 'ContraventionGroup'
        CrudApiManager::UpdateData.call(api_data) # Service Request to send values to be updated to Core
        flash[:notice] = "La classe a été modifiée."
        redirect_to groups_url 
      else
        flash[:alert] = @group.errors.full_messages.joint(', ')
        render :edit
      end
  end 

  def destroy 
    api_data = @group.as_json(root: 'request', only: [:code])
    api_data['request']['model'] = 'ContraventionGroup'
    CrudApiManager::DeleteData.call(api_data) # Service Request to send values to be deleted to Core
    if @group.destroy
       flash[:notice] = "Classe supprimé avec succès"
       redirect_to groups_url
    else
       flash[:alert] = "Impossible de supprimer la Classe"
       redirect_to groups_url
    end
  end


  def import

    data = ContraventionGroup.open_spreadsheet(params[:file])

      if data == "nok"
        flash[:alert] = "Format de fichier incorrect"
        redirect_to groups_path
      else

        headers = data.row(1)
        header_for_group_table = []

        if headers.length == 3

          headers.each_with_index do |header, idx|
            if  header == "CODE"
              header_for_group_table[0] = 'code'
            elsif  header == "LIBELLE"
              header_for_group_table[1] = 'label'
            elsif  header == "DESCRIPTION"
              header_for_group_table[2] = 'description'
            else
              flash[:alert] = "colonnes non conforme"
            end
          end

        else
          flash[:alert] = "fichier non conforme"
        end

        if header_for_group_table.empty?
          flash[:alert] = "Format de colonne non conforme"
        else

         data.each_with_index do |row, idx|

            next if idx == 0 #skip header

            #create Hash from headers and cells
            group_data = Hash[[header_for_group_table, row].transpose]

            # if the agent exists update the row
            group_already_saved = ContraventionGroup.find_by(code: group_data['code'])
            if group_already_saved #ContraventionGroup.exists?(code: group_data['code'])

              #ContraventionGroup.update(group_data)
              #ContraventionGroup.where(code: group_data['code']).limit(1).update_all(group_data)
              group_already_saved.update!(group_data)
              api_data = group_already_saved.as_json(root: 'request', only: [:code, :label, :description])
              api_data['request']['model'] = 'ContraventionGroup'
              CrudApiManager::UpdateData.call(api_data)

            else
              group = ContraventionGroup.new(group_data)
              group.author_id = current_user.id
              group.save!
              api_data = group.as_json(root: 'request', only: [:code, :label, :description])
              api_data['request']['model'] = 'ContraventionGroup'
              CrudApiManager::InsertData.call(api_data)
            end


           flash[:notice] = "Importation effectuée avec succès"

         end
        end
       redirect_to groups_url
      end

  end


  private

  def set_group
   @group = ContraventionGroup.find(params[:id])
  end

  def group_params
    params.require(:contravention_group).permit(:code, :label, :description)
  end

end