class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :last_location, :gender, :infected

  has_many :resources
end
