require 'factory_bot'

FactoryBot.define do
  factory :user do
    organization
    sequence(:email) { |n| "fake-#{n}@example.com" }
    password { 'password' }
    confirmed_at { Time.current }
  end
end
