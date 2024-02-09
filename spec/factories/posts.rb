FactoryBot.define do
  factory :post do
    content {Faker::Lorem.paragraph_to_chars}
    user
  end
end
