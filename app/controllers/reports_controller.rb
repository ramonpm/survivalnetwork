class ReportsController < ApplicationController
  def infections
    json_response(Survivor.infection_report)
  end

  def resource_per_survivor
    json_response(Survivor.resource_per_survivor_report)
  end

  def lost_points
    json_response(Survivor.lost_points_report)
  end
end
