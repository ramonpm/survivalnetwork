require 'rails_helper'

RSpec.describe 'Trades requests:', type: :request do
  describe 'registering a trade' do
    context 'with valid data' do
      let!(:owner_a) do
        create(:survivor, name: 'OwnerA', age: 20, gender: 'F',
                          last_location: '16.446622,15.996094',
                          resources_attributes: [{ name: 'Water' }])
      end
      let!(:owner_b) do
        create(:survivor, name: 'OwnerB', age: 20, gender: 'F',
                          last_location: '16.446622,15.996094',
                          resources_attributes: [{ name: 'Ammunition' },
                                                 { name: 'Ammunition' },
                                                 { name: 'Ammunition' },
                                                 { name: 'Ammunition' }])
      end
      before do
        post '/trades', params: {
          box_a: {
            owner_id: owner_a.id,
            resources: [{ name: 'Water' }]
          },
          box_b: {
            owner_id: owner_b.id,
            resources: [{ name: 'Ammunition' },
            { name: 'Ammunition' },
            { name: 'Ammunition' },
            { name: 'Ammunition' }]
          }
        }
      end

      it 'changes owners' do
        expect(Survivor.find(owner_a.id).resources.where(name: 'Ammunition').count).to eq(4)
        expect(Survivor.find(owner_b.id).resources.where(name: 'Water').count).to eq(1)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(204)
      end
    end

    context 'with infected survivor' do
      let!(:owner_a) do
        create(:survivor, name: 'OwnerA', age: 20, gender: 'F',
                          last_location: '16.446622,15.996094',
                          resources_attributes: [{ name: 'Water' }])
      end
      let!(:owner_b) do
        create(:survivor, name: 'OwnerB', age: 20, gender: 'F',
                          last_location: '16.446622,15.996094',
                          infected: true,
                          resources_attributes: [{ name: 'Ammunition' },
                                                 { name: 'Ammunition' },
                                                 { name: 'Ammunition' },
                                                 { name: 'Ammunition' }])
      end
      before do
        post '/trades', params: {
          box_a: {
            owner_id: owner_a.id,
            resources: [{ name: 'Water' }]
          },
          box_b: {
            owner_id: owner_b.id,
            resources: [{ name: 'Ammunition' },
            { name: 'Ammunition' },
            { name: 'Ammunition' },
            { name: 'Ammunition' }]
          }
        }
      end

      it 'returns an error response' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
