require 'rails_helper'

RSpec.describe 'Trades requests:', type: :request do
  describe 'registering a trade' do
    context 'with valid data' do
      let!(:owner_a_id) do
        Survivor.create(name: 'OwnerA', age: 20, gender: 'F',
                        last_location: '16.446622,15.996094',
                        resources_attributes: [{ name: 'Water' }])
      end
      before do
        post '/trades', params: {
          box_a: {
            owner_id: 1,
            resources: [
              {
                name: 'Water'
              }
            ]
          },
          box_b: {
            owner_id: 2,
            resources: [
              {
                name: 'Ammunition'
              },
              {
                name: 'Ammunition'
              },
              {
                name: 'Ammunition'
              },
              {
                name: 'Ammunition'
              }
            ]
          }
        }
      end

      it 'saves the flag' do
        expect(Survivor.find.resources.where(name: 'Ammunition').size).to eq(4)
        expect(Survivor.find.resources.where(name: 'Water').size).to eq(1)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
