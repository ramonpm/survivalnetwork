class SurvivorsController < ApplicationController
   def index
    json_response(Survivor.all)
   end 
   
    def create
        survivor = Survivor.create!(survivor_params)
        json_response(survivor, :created)
    end

    def update_location
        survivor = Survivor.find(params[:id])
        survivor.update!(last_location: location_param[:location])
        json_response(survivor, :ok)
    end

    private

    def survivor_params
        params.permit(:name, :age, :gender, :last_location, :resources_attributes => [:name, :points])
    end

    def location_param
        params.permit(:location)
    end
end
