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

  # before_validation :test

  # def test
  #     puts self.inspect
  # end
end
