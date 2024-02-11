class Organization < ApplicationRecord
  has_many :documents, dependent: :destroy

  before_create :set_subdomain

  private

  def set_subdomain
    self.subdomain ||= name.parameterize
  end
end
