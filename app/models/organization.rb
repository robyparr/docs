# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :repositories, dependent: :destroy
  has_many :documents, dependent: :destroy

  before_create :set_subdomain

  private

  def set_subdomain
    self.subdomain ||= name.parameterize
  end
end
