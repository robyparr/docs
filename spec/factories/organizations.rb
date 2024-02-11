# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "org-#{n}" }
    subdomain { name }
  end
end
