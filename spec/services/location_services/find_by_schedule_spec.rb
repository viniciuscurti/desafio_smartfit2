require 'rails_helper'

RSpec.describe LocationServices::FindBySchedule, type: :service do
  describe '#call' do
    let!(:opened_location) { create(:location, opened: true) }
    let!(:closed_location) { create(:location, opened: false) }
    let(:params) do
      { "[locations]" => { "schedules" => { "hours" => "06h às 12h" } },
        "include_closed" => include_closed, "commit" => "Encontrar unidade" }
    end
    let(:service) { described_class.new(params) }

    context 'when include_closed is 0' do
      let(:include_closed) { '0' }

      it 'returns only opened locations' do
        expect(service.call).to include(opened_location)
        expect(service.call).not_to include(closed_location)
      end
    end

    context 'when include_closed is 1' do
      let(:include_closed) { '1' }

      it 'returns both opened and closed locations' do
        expect(service.call).to include(opened_location, closed_location)
      end
    end
  end
end
