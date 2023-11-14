FactoryBot.define do
  factory :location do
    uuid { Faker::Internet.uuid }
    title { Faker::Address.community }
    content { Faker::Address.street_address }
    opened { false }
    mask { "required" }
    towel { "required" }
    fountain { "partial" }
    locker_room { "allowed" }
    schedules do
      [{ "weekdays" => "Seg. à Sex.", "hour" => "06h às 22h" },
       { "weekdays" => "Sáb.", "hour" => "Fechada" },
       { "weekdays" => "Dom.", "hour" => "Fechada" }]
    end
  end
end
