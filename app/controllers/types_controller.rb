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

  def import

    data = ContraventionType.open_spreadsheet(params[:file])

      if data == "nok"
        flash[:alert] = "Format de fichier incorrect"
        redirect_to types_path
      else

        headers = data.row(1)

        header_for_type_table = []

        if headers.length == 3

          headers.each_with_index do |header, idx|
            if  header == "CODE"
              header_for_type_table[0] = 'code'
            elsif  header == "LIBELLE"
              header_for_type_table[1] = 'label'
            elsif  header == "CLASSE"
              header_for_type_table[2] = 'contravention_group_id'
            else
              flash[:alert] = "colonnes non conforme"
            end
          end

        else
          flash[:alert] = "fichier non conforme"
        end

        if header_for_type_table.empty?
          flash[:alert] = "Format de colonne non conforme"
        else
            data.each_with_index do |row, idx|
              next if idx == 0 #skip header

              #create Hash from headers and cells
              type_data = Hash[[header_for_type_table, row].transpose]

              # fetch the corresponding id from the spécifique classe name
              type_record = ContraventionGroup.where(label: type_data['contravention_group_id']).take

              if type_record
                type_record_id = type_record.id
                type_data['contravention_group_id'] = type_record_id
              else 
                flash[:alert] = "la classe << #{type_data['contravention_group_id']} >> à la ligne << #{idx.to_i + 1} >> est inconnue"
                break
              end

              # if the code type exists update the row
              checking_code = ContraventionType.exists?(code: type_data['code'])
              if checking_code
                  code = ContraventionType.find_by(code: type_data['code'])
                  code.label = type_data['label']
                  code.contravention_group_id = type_data['contravention_group_id']
                  code.author_id = current_user
                  code.save
              else

                type = ContraventionType.new(type_data)
                type.save!
              end
              flash[:notice] = "Importation effectuée avec succès"
            end
        end
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