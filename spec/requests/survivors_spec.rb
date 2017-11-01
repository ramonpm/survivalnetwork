require 'rails_helper'

RSpec.describe 'Survivors requests:', type: :request do
  describe 'posting a survivor' do
    context 'with all the required fields' do
      before do
        post '/survivors', params: {
          name: 'Max Chow',
          age: 28, gender: 'M',
          last_location: '36.800488,-89.121094',
          resources_attributes: [
            {
              name: 'Water'
            },
            {
              name: 'Ammunition'
            }
          ]
        }
      end

      it 'saves the survivor' do
        expect(json['name']).to eq('Max Chow')
      end

      it "saves the suvivor's resources" do
        expect(json['resources'].size).to be > 0
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(201)
      end
    end

    context 'without location' do
      before do
        post '/survivors', params: {
          name: 'Max Chow',
          age: 28, gender: 'M',
          resources_attributes: [
            {
              name: 'Water'
            },
            {
              name: 'Ammunition'
            }
          ]
        }
      end

      it 'returns an error response' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'updating location' do
    let!(:survivor) { create(:survivor) }

    context 'with valid input' do
      let(:new_location) { '32.800488,-82.121094' }
      before { put "/survivors/#{survivor.id}/update-location", params: { last_location: new_location } }

      it 'saves the new location' do
        expect(json['last_location']).to eq(new_location)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end
    end

    context 'without the new location' do
      before { put "/survivors/#{survivor.id}/update-location", params: { last_location: '' } }

      it 'returns an error response' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
