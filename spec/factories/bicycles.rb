# frozen_string_literal: true

FactoryBot.define do
  factory :bicycle do
    model       { Faker::Vehicle.version  }
    color       { Faker::Vehicle.color  }
    price       { Faker::Commerce.price(range: 0..300.0, as_string: true) }
    style       { ['off-road', 'kids-bike', 'electric-bike'].sample }
    description { 'This is a fake description for a fake bike which can run faster than a nigga seen around by the cops selling weed.' }

    after(:build) do |bicycle|
      bicycle.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'bike.jpg')),
        filename: 'bike.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
