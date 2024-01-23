class Organization < ApplicationRecord
  before_create :set_subdomain

  private

  def set_subdomain
    self.subdomain = name.parameterize
  end
end
