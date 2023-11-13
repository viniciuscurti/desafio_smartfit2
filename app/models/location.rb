class Location < ApplicationRecord
  serialize :schedules, JSON

  def locker_room_image
    case locker_room
    when 'allowed'
      'required-lockerroom'
    when 'partial'
      'partial-lockerroom'
    else
      'forbidden-lockerroom'
    end
  end

  def schedule_for_weekday(weekday)
    schedule = schedules.find { |s| s['weekdays'] == weekday }
    schedule ? schedule['hour'] : 'Fechada'
  end

  def weekday_schedule_week
    schedule_for_weekday('Seg. à Sex.')
  end

  def weekday_schedule_sat
    schedule_for_weekday('Sáb.')
  end

  def weekday_schedule_sun
    schedule_for_weekday('Dom.')
  end

  def opened_status
    opened ? 'Aberto' : 'Fechado'
  end

  def mask_image
    mask == 'required' ? 'required-mask' : 'recommended-mask'
  end

  def towel_image
    towel == 'required' ? 'required-towel' : 'recommended-towel'
  end

  def fountain_image
    fountain == 'partial' ? 'partial-fountain' : 'forbidden-fountain'
  end

  def normalized_content
    content.gsub(/<\/?[^>]*>/, " ").gsub("&#8211;", " ")
  end

  def normalized_title
    title.gsub(/<\/?[^>]*>/, " ").gsub("&#8211;", " ")
  end

  def normalized_full_address
    "#{street}, #{region}, #{city_name}, #{state_name} - #{uf}"
  end
end
