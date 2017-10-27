class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :last_location, :gender

  has_many :resources
end
