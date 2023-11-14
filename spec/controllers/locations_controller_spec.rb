require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  describe "GET #search_results" do
    let(:params) do
      { "[locations]" => { "schedules" => { "hours" => "06h às 12h" } },
        "include_closed" => '0', "commit" => "Encontrar unidade" }
    end

    context 'when [locations] param is present' do
      before do
        allow(LocationServices::FindBySchedule).to receive(:new).and_return(double(call: :found))
      end

      it 'calls LocationServices::FindBySchedule' do
        get :search_results, params: params, format: :turbo_stream
        expect(LocationServices::FindBySchedule).to have_received(:new)
      end
    end

    context 'when [locations] param is not present' do
      let(:params) { {} }

      before do
        allow(LocationServices::Listener).to receive(:new).and_return(double(call: :found))
      end

      it 'calls LocationServices::Listener' do
        get :search_results, params: params, format: :turbo_stream
        expect(LocationServices::Listener).to have_received(:new)
      end
    end
  end
end
