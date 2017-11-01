class Survivor < ApplicationRecord
  scope :healthy, -> { where(infected: false) }

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
      owns = resources.where(name: key)
      return nil if owns.count < value
      # separating the resources to trade
      db_trading_resources += owns.take(value)
    end
    db_trading_resources
  end

  def self.infection_report
    all = Survivor.all
    infected = all.where(infected: true).count
    infected = (infected.to_f / all.count.to_f) * 100
    { infected: "#{infected}%", non_infected: "#{100 - infected}%" }
  end

  def self.resource_per_survivor_report
    result = ActiveRecord::Base.connection.execute('SELECT t.name, AVG(t.qty) as average
                              FROM (SELECT r.name, r.survivor_id, COUNT(id) as qty
                                    FROM resources r GROUP BY r.name, r.survivor_id) t
                              GROUP BY t.name')
    report = {}
    result.each do |r|
      report[r['name']] = r['average']
    end
    report
  end

  def self.lost_points_report
    { lost_points: Survivor.where(infected: true).joins(:resources).sum('resources.points') }
  end

  # before_validation :test

  # def test
  #     puts self.inspect
  # end
end
