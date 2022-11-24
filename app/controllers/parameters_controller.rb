class ParametersController < ApplicationController

    before_action :fetch_parameter, only: [:show, :update]

    def index 
        @parameters = Parameter.order(created_at: :desc)
    end

    def show
    end

    def update
       @parameter.assign_attributes(parameter_params)
       if @parameter.save
        api_data = @parameter.as_json(root: 'request', only: [:name, :description, :value, :slug])
        api_data['request']['model'] = 'Parameter'
        CrudApiManager::UpdateData.call(api_data)
        flash[:notice] = "Le Paramètre a été modifié"
        redirect_to parameters_url
       else
        flash[:alert] = @parameter.errors.full_messages.join(', ')
        render :show
       end
    end


    private

    def parameter_params
        params.require(:parameter).permit(:name, :description, :value, :slug)
    end

    def fetch_parameter
        @parameter = Parameter.friendly.find(params[:id])
    end

end