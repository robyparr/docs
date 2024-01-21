class Organization < ApplicationRecord
  before_create :set_slug

  private

  def set_slug
    self.slug = name.parameterize
  end
end
