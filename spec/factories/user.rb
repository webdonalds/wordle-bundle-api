FactoryBot.define do
  factory :user, class: User do
    display_name { Faker::Internet.username }
    email { Faker::Internet.email }
  end
end
