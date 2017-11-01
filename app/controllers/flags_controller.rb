class FlagsController < ApplicationController
  def index
    json_response(Flag.all)
  end

  def create
    Flag.create!(flag_params)
    head :no_content
  end

  private

  def flag_params
    params.permit(:reporter_id, :infected_id)
  end
end
