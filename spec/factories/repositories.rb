# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    organization
    user
    name { 'A repository' }
  end
end
