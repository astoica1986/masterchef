FactoryBot.define do
  factory :author do
    name { Faker::Name.unique.name }
  end

  factory :recipe do
    name { Faker::Name.unique.name }
    rate { 1.0 }
    author_tip { Faker::Company.bs }
    budget { Faker::Lorem.word }
    difficulty { Faker::Lorem.word }
    people_quantity  { Faker::Number.number(digits: 1) }
    cook_time { Faker::Number.number(digits: 2) }
    prep_time { Faker::Number.number(digits: 2) }
    total_time { Faker::Number.number(digits: 2) }
    nb_comments { Faker::Number.number(digits: 2) }
    image { Faker::Internet.url }
    tags { 5.times.collect { Faker::Lorem.word } }
    ingredients { 5.times.collect { Faker::Lorem.word } }

    association :author
  end
end
