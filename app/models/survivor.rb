class Survivor < ApplicationRecord
  has_many :resources
  has_many :reports, class_name: 'Flag', foreign_key: 'reporter_id'
  has_many :flags, class_name: 'Flag', foreign_key: 'infected_id'

  validates :name, presence: true
  validates :age, presence: true
  validates :gender, presence: true
  validates :last_location, presence: true
  validates :resources, presence: true

  accepts_nested_attributes_for :resources

  def trading_resources(trading_resources)
    points_by_type = {}
    # how many points need by each type of resource
    trading_resources.each do |tr|
      points_by_type[tr['name']] = points_by_type[tr['name']].to_i + 1
    end
    db_trading_resources = []
    # checking if the survivor has the needed amount
    points_by_type.each do |key, value|
      owns = self.resources.where(name: key)
      return nil if owns.count < value
      # separating the resources to trade
      db_trading_resources += owns.take(value)
    end
    db_trading_resources
  end

  # before_validation :test

  # def test
  #     puts self.inspect
  # end
end
