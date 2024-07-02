# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :api_token do
    repository
    sequence(:name, 1) { |n| "Token #{n}" }
  end
end
