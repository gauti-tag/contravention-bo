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
    if @group.contravention_notebooks.exists? 
      flash[:alert] = "Classe affectée à un carnet"
    elsif  @group.contravention_types.exists?
      flash[:alert] = "Classe affectée à un type"
    else
      if @group.update(group_params)
        flash[:notice] = "La classe a été modifiée."
        redirect_to groups_url 
      else
        flash[:alert] = @group.errors.full_messages.joint(', ')
        render :edit
      end
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


  def import

    data = ContraventionGroup.open_spreadsheet(params[:file])

      if data == "nok"
        flash[:alert] = "Format de fichier incorrect"
        redirect_to groups_path
      else

        headers = data.row(1)
        header_for_group_table = []

        if headers.length == 4

          headers.each_with_index do |header, idx|
            if  header == "CODE"
              header_for_group_table[0] = 'code'
            elsif  header == "LIBELLE"
              header_for_group_table[1] = 'label'
            elsif  header == "MONTANT"
              header_for_group_table[2] = 'amount'
            elsif  header == "DESCRIPTION"
              header_for_group_table[3] = 'description'
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
            if ContraventionGroup.exists?(code: group_data['code'])

              ContraventionGroup.update(group_data)

            else

              group = ContraventionGroup.new(group_data)
              group['author_id'] = current_user
              group.save!
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
    params.require(:contravention_group).permit(:code, :label, :amount, :description)
  end

end