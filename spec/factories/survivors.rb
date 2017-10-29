FactoryBot.define do
  factory :survivor do
    name 'Max Chow'
    age 28
    gender "M"
    last_location "16.446622,15.996094"
    resources_attributes [
      {
          name: 'Water',
          points: 4
      },
      {
          name: 'Ammunition',
          points: 1
      }
    ]
  end
end
