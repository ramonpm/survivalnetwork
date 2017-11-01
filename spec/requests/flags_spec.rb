require 'rails_helper'

RSpec.describe 'Flags requests:', type: :request do
  describe 'flagging a survival as infected' do
    let!(:survivors) { create_list(:survivor, 10) }
    let(:infected) { survivors.last }

    context 'with valid data' do
      before do
        post '/flags', params: {
          reporter_id: survivors.first.id,
          infected_id: infected.id
        }
      end

      it 'saves the flag' do
        expect(infected.flags.size).to be > 0
      end

      it 'should keep the reported as not infected' do
        expect(Survivor.find(infected.id).infected?).to_not be_truthy
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(204)
      end
    end

    context '3 flags to same survival' do
      it 'marks the survival infected' do
        post '/flags', params: {
          reporter_id: survivors[0].id,
          infected_id: infected.id
        }

        post '/flags', params: {
          reporter_id: survivors[1].id,
          infected_id: infected.id
        }

        post '/flags', params: {
          reporter_id: survivors[2].id,
          infected_id: infected.id
        }

        expect(Survivor.find(infected.id).infected?).to be_truthy
      end
    end

    context 'same reporter and same victim' do
      it 'should save only one report' do
        post '/flags', params: {
          reporter_id: survivors[0].id,
          infected_id: infected.id
        }

        post '/flags', params: {
          reporter_id: survivors[0].id,
          infected_id: infected.id
        }

        post '/flags', params: {
          reporter_id: survivors[0].id,
          infected_id: infected.id
        }

        expect(Survivor.find(infected.id).infected?).to_not be_truthy
        expect(Flag.where(reporter: survivors[0], infected: infected).count).to eq(1)
      end
    end
  end
end
