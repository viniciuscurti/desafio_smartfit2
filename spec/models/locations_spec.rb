require 'rails_helper'

RSpec.describe Location, type: :model do
  describe '#locker_room_image' do
    it 'returns the correct image name when locker_room is allowed' do
      location = Location.new(locker_room: 'allowed')
      expect(location.locker_room_image).to eq('required-lockerroom')
    end

    it 'returns the correct image name when locker_room is partial' do
      location = Location.new(locker_room: 'partial')
      expect(location.locker_room_image).to eq('partial-lockerroom')
    end

    it 'returns the correct image name when locker_room is forbidden' do
      location = Location.new(locker_room: 'forbidden')
      expect(location.locker_room_image).to eq('forbidden-lockerroom')
    end
  end

  describe '#opened_status?' do
    it "returns 'Aberto' when opened is true" do
      location = Location.new(opened: true)
      expect(location.opened_status?).to eq('Aberto')
    end

    it "returns 'Fechado' when opened is false" do
      location = Location.new(opened: false)
      expect(location.opened_status?).to eq('Fechado')
    end
  end

  describe '#normalized_full_address' do
    it 'returns the full address with normalized formatting' do
      location = Location.new(street: 'Rua Teste', region: 'Bairro Teste', city_name: 'Cidade Teste',
                              state_name: 'Estado Teste', uf: 'UF Teste')
      expect(location.normalized_full_address).to eq('Rua Teste, Bairro Teste, Cidade Teste, Estado Teste - UF Teste')
    end
  end

  describe '#normalized_content' do
    it 'returns the content with normalized formatting' do
      location = Location.new(content: '<p>Teste</p>')
      expect(location.normalized_content).to eq(' Teste ')
    end
  end

  describe '#normalized_title' do
    it 'returns the title with normalized formatting' do
      location = Location.new(title: '<p>Teste</p>')
      expect(location.normalized_title).to eq(' Teste ')
    end
  end

  describe '#mask_image' do
    it 'returns the correct image name when mask is required' do
      location = Location.new(mask: 'required')
      expect(location.mask_image).to eq('required-mask')
    end

    it 'returns the correct image name when mask is recommended' do
      location = Location.new(mask: 'recommended')
      expect(location.mask_image).to eq('recommended-mask')
    end
  end

  describe '#towel_image' do
    it 'returns the correct image name when towel is required' do
      location = Location.new(towel: 'required')
      expect(location.towel_image).to eq('required-towel')
    end

    it 'returns the correct image name when towel is recommended' do
      location = Location.new(towel: 'recommended')
      expect(location.towel_image).to eq('recommended-towel')
    end
  end

  describe '#fountain_image' do
    it 'returns the correct image name when fountain is partial' do
      location = Location.new(fountain: 'partial')
      expect(location.fountain_image).to eq('partial-fountain')
    end

    it 'returns the correct image name when fountain is forbidden' do
      location = Location.new(fountain: 'forbidden')
      expect(location.fountain_image).to eq('forbidden-fountain')
    end
  end
end
