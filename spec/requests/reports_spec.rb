require 'rails_helper'

RSpec.describe 'Reports requests:', type: :request do
  describe 'infections rates' do
    context 'with only new survivors added' do
      let!(:survivors) do
        create_list(:survivor, 10)
      end

      before do
        get '/reports/infections'
      end

      it 'should return 100% non-infected and 0% infected' do
        expect(json['infected']).to eq('0.0%')
        expect(json['non_infected']).to eq('100.0%')
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with some infected survivors added' do
      let!(:survivors) do
        create_list(:survivor, 6)
        create_list(:survivor, 4, infected: true)
      end

      before do
        get '/reports/infections'
      end

      it 'should return 60% non-infected and 40% infected' do
        expect(json['infected']).to eq('40.0%')
        expect(json['non_infected']).to eq('60.0%')
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'average amount of each kind of resource per survivor' do
    let!(:survivors) do
      create_list(:survivor, 10, name: 'Testing', age: 20, gender: 'F',
                                 last_location: '16.446622,15.996094',
                                 resources_attributes: [{ name: 'Water' },
                                                        { name: 'Water' },
                                                        { name: 'Ammunition' },
                                                        { name: 'Ammunition' },
                                                        { name: 'Ammunition' },
                                                        { name: 'Ammunition' },
                                                        { name: 'Food' },
                                                        { name: 'Food' },
                                                        { name: 'Food' },
                                                        { name: 'Medication' }])
    end

    before do
      get '/reports/resource-per-survivor'
    end

    it 'should return 2 waters, 4 ammo, 3 food and 1 medication' do
      expect(json['Water']).to eq(2)
      expect(json['Ammunition']).to eq(4)
      expect(json['Food']).to eq(3)
      expect(json['Medication']).to eq(1)
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'lost points because of infected survivors' do
    let!(:survivors) do
      # 23 points each survivor
      create_list(:survivor, 2, name: 'Testing', age: 20, gender: 'F',
                                 last_location: '16.446622,15.996094',
                                 infected: true,
                                 resources_attributes: [{ name: 'Water' },
                                                        { name: 'Water' },
                                                        { name: 'Ammunition' },
                                                        { name: 'Ammunition' },
                                                        { name: 'Ammunition' },
                                                        { name: 'Ammunition' },
                                                        { name: 'Food' },
                                                        { name: 'Food' },
                                                        { name: 'Food' },
                                                        { name: 'Medication' }])
    end

    before do
      get '/reports/lost-points'
    end

    it 'should return 46 lost points as total' do
      expect(json['lost_points']).to eq(46)
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(200)
    end
  end
end
