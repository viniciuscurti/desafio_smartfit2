module LocationServices
  class FindBySchedule
    def initialize(params)
      @hours = params['[locations]']['schedules']['hours']
      @include_closed = params['include_closed']
    end

    def start_hour
      @hours.split(' às ').first.to_time(format: '%H:%M')
    end

    def end_hour
      @hours.split(' às ').last.to_time(format: '%H:%M')
    end

    def opened_locations
      locations = Location.where(opened: true)
      locations.uniq.select do |location|
        location.schedules.any? do |schedule|
          next if schedule['hour'] == 'Fechada'

          next if schedule['weekdays'] == 'Obs.:'

          schedule_start_hour, schedule_end_hour = schedule['hour'].split(' às ').map do |h|
            Time.strptime(h.gsub('h', ''), '%H')
          end
          (schedule_start_hour >= start_hour && schedule_end_hour <= end_hour) || schedule_start_hour >= start_hour || schedule_end_hour <= end_hour
        end
      end
    end

    def closed_locations
      Location.where(opened: false)
    end

    def call
      locations = opened_locations
      locations += closed_locations if @include_closed == '1'
      locations.uniq
    end
  end
end
