class Creator
  def initialize(params)
    @uuid = params['uuid']
    @title = params['title']
    @content = params['content']
    @opened = params['opened']
    @mask = params['mask']
    @towel = params['towel']
    @fountain = params['fountain']
    @locker_room = params['locker_room']
    @schedules = params['schedules']
    @street = params['street']
    @region = params['region']
    @city_name = params['city_name']
    @state_name = params['state_name']
    @uf = params['uf']
  end

  def matching_params(location)
    location.uuid = @uuid
    location.title = @title
    location.content = @content
    location.opened = @opened
    location.mask = @mask
    location.towel = @towel
    location.fountain = @fountain
    location.locker_room = @locker_room
    location.schedules = @schedules
    location.street = @street
    location.region = @region
    location.city_name = @city_name
    location.state_name = @state_name
    location.uf = @uf
    location
  end

  def parsing_schedule(location)
    schedules = {}

    @schedules.each do |schedule|
      schedules[:weekday] << schedule[:weekday]
      schedules[:hours] << schedule[:hours]
    end

    location.schedules = schedules
  end

  def call
    location = Location.new
    matching_params(location)
    parsing_schedule(location)
    location.save!
  end
end
