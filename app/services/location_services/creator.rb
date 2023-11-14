module LocationServices
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
      attributes = %i[uuid title content opened mask towel fountain locker_room street region city_name
                      state_name uf]

      attributes.each do |attribute|
        value = instance_variable_get("@#{attribute}")
        location.send("#{attribute}=", value) if value.present?
      end

      location
    end

    def parsing_schedule(location)
      schedules = @schedules.map do |schedule|
        {
          hours: schedule['hour'],
          weekdays: schedule['weekdays']
        }
      end
      location.schedules = { 'hours' => schedules.map { |schedule| schedule[:hours] }, 'weekdays' => schedules.map { |schedule|
 schedule[:weekdays] } } if schedules.present?
      location
    end

    def call
      location = Location.new
      matching_params(location)
      parsing_schedule(location) if @schedules.present?
      location.save!
    end
  end
end
