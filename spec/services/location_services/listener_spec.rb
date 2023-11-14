require 'rails_helper'

RSpec.describe LocationServices::Listener, type: :service do
  describe '#call' do
    let!(:opened_location) { create(:location, opened: true) }
    let!(:closed_location) { create(:location, opened: false) }
    let(:service) { described_class.new }

    context 'it should return all locations' do

      it 'returns both opened and closed locations' do
        expect(service.call).to include(opened_location, closed_location)
      end
    end
  end
end
