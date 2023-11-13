require 'json'
require 'httparty'

def generate_unique_id(id)
  while Location.exists?(id: id)
    id = id.to_i + 1
  end
  id
end

puts 'Limpando o banco de dados...'
Location.destroy_all

puts 'Creating locations...'

location_url = 'https://test-frontend-developer.s3.amazonaws.com/data/locations.json'
location_response = HTTParty.get(location_url)
location_data = JSON.parse(location_response.body)
location_data = location_data['locations']

location_data.each do |location|
  location['id'] = generate_unique_id(location['id'])
  Location.create!(uuid: location['id'].to_s, title: location['title'], content: location['content'],
                   opened: location['opened'], mask: location['mask'], towel: location['towel'],
                   fountain: location['fountain'], locker_room: location['locker_room'],
                   schedules: location['schedules'], street: location['street'], region: location['region'],
                   city_name: location['city_name'], state_name: location['state_name'], uf: location['uf'])
end

puts 'Locations created!'
