# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :document do
    organization
    sequence(:path) { |n| "file-#{n}.md" }
    content { '# A Document' }
  end
end
