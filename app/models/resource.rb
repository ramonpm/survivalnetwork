class Resource < ApplicationRecord
  belongs_to :survivor

  validates :survivor, presence: true
  validates :name, presence: true
  validates :points, presence: true

  before_validation :set_points

  def self.trade!(params)
    owner_a = Survivor.find(params['box_a']['owner_id'])
    owner_b = Survivor.find(params['box_b']['owner_id'])
    # check if the survivors have the resources
    resources_a = owner_a.trading_resources(params['box_a']['resources'])
    resources_b = owner_b.trading_resources(params['box_b']['resources'])
    # check if resources are equally in points
    total_a = resources_a.inject(0) { |sum, r| sum + r.points }
    total_b = resources_b.inject(0) { |sum, r| sum + r.points }
    raise ActiveRecord::RecordInvalid if total_a != total_b
    # change reference ids
    transaction do
      begin
        Resource.where("id in (#{resources_ids(resources_a)})").update_all("survivor_id = #{owner_b.id}")
        Resource.where("id in (#{resources_ids(resources_b)})").update_all("survivor_id = #{owner_a.id}")
      rescue
        raise ActiveRecord::Rollback
      end
    end
    true
  rescue
    raise ActiveRecord::RecordInvalid
  end

  private

  def self.resources_ids(rs)
    ids = rs.map {|r| r.id}
    ids.join(',')
  end

  def set_points
    self.points = case name.downcase
                  when 'water'
                    4
                  when 'food'
                    3
                  when 'medication'
                    2
                  when 'ammunition'
                    1
                  else
                    0
             end
  end
end
