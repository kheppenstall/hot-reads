FactoryGirl.define do
  factory :link do
    url      { Faker::Internet.url + rand(1000).to_s }
  end
end
