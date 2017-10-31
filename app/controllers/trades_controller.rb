class TradesController < ApplicationController
  def create
    Resource.trade!(trade_params)
    head :no_content
  end

  private

  def trade_params
    params.permit({:box_a => [:owner_id, :resources => [:name]]}, {:box_b => [:owner_id, :resources => [:name]]})
  end
end
