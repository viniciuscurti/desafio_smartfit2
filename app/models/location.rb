class Location < ApplicationRecord
  serialize :schedules, coder: JSON

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

  def opened_status?
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
    content.gsub(%r{</?[^>]*>}, " ").gsub("&#8211;", " ")
  end

  def normalized_title
    title.gsub(%r{</?[^>]*>}, " ").gsub("&#8211;", " ")
  end

  def normalized_full_address
    "#{street}, #{region}, #{city_name}, #{state_name} - #{uf}"
  end
end
