class Survivor < ApplicationRecord
    has_many :resources

    validates :name, presence: true
    validates :age, presence: true
    validates :gender, presence: true
    validates :last_location, presence: true
    validates :resources, presence: true

    accepts_nested_attributes_for :resources
end
