require 'rails_helper'

RSpec.describe LocationServices::Creator do
  let(:params) do
    {
      'uuid' => '123',
      'title' => 'SmartFit',
      'content' => 'The best gym in town',
      'opened' => true,
      'street' => 'Av. Paulista, 123',
      'region' => 'Bela Vista',
      'city_name' => 'São Paulo',
      'state_name' => 'São Paulo',
      'uf' => 'SP'
    }
  end

  let(:location) { instance_double(Location) }

  before do
    allow(Location).to receive(:new).and_return(location)
  end

  it 'sets the location attributes and saves it' do
    creator = described_class.new(params)

    expect(Location).to receive(:new).with(no_args).and_return(location)

    expect(location).to receive(:uuid=).with('123')
    expect(location).to receive(:title=).with('SmartFit')
    expect(location).to receive(:content=).with('The best gym in town')
    expect(location).to receive(:opened=).with(true)
    expect(location).to receive(:street=).with('Av. Paulista, 123')
    expect(location).to receive(:region=).with('Bela Vista')
    expect(location).to receive(:city_name=).with('São Paulo')
    expect(location).to receive(:state_name=).with('São Paulo')
    expect(location).to receive(:uf=).with('SP')

    expect(location).to receive(:save!)

    creator.call
  end

  it 'sets the location schedules and saves it' do
    params['schedules'] = [{ "weekdays" => "Seg. à Sex.", "hour" => "06h às 22h" },
                           { "weekdays" => "Sáb.", "hour" => "Fechada" },
                           { "weekdays" => "Dom.", "hour" => "Fechada" }]

    creator = described_class.new(params)

    expect(Location).to receive(:new).with(no_args).and_return(location)

    expect(location).to receive(:uuid=).with('123')
    expect(location).to receive(:title=).with('SmartFit')
    expect(location).to receive(:content=).with('The best gym in town')
    expect(location).to receive(:opened=).with(true)
    expect(location).to receive(:street=).with('Av. Paulista, 123')
    expect(location).to receive(:region=).with('Bela Vista')
    expect(location).to receive(:city_name=).with('São Paulo')
    expect(location).to receive(:state_name=).with('São Paulo')
    expect(location).to receive(:uf=).with('SP')

    expect(location).to receive(:schedules=).with(
      { "weekdays" => ["Seg. à Sex.", "Sáb.", "Dom."],
        "hours" => ["06h às 22h", "Fechada", "Fechada"] }
    )

    expect(location).to receive(:save!)

    creator.call
  end
end
