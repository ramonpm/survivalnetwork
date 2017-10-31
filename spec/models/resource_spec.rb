require 'rails_helper'

RSpec.describe Resource, type: :model do
  context 'creation' do
    it 'should have the right points' do
      survivor = create(:survivor, {
        name: 'Max Chow',
        age: 28, gender: 'M',
        last_location: '36.800488,-89.121094',
        resources_attributes: [
            {
                name: 'Water'
            },
            {
              name: 'Food'
            },
            {
              name: 'Medication'
            },
            {
                name: 'Ammunition'
            }
        ]
      })
      water = survivor.resources.where(name: 'Water').first
      food = survivor.resources.where(name: 'Food').first
      medication = survivor.resources.where(name: 'Medication').first
      ammunition = survivor.resources.where(name: 'Ammunition').first
      expect(water.points).to eq(4)
      expect(food.points).to eq(3)
      expect(medication.points).to eq(2)
      expect(ammunition.points).to eq(1)
    end
  end
end
