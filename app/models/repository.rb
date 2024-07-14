# frozen_string_literal: true

class Repository < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  has_many :documents, dependent: :destroy
  has_many :root_documents, -> { where parent_id: nil }, class_name: 'Document'
  has_many :api_tokens, dependent: :destroy

  validates :name, presence: true

  before_update :set_public_slug, if: :public?

  private

  def set_public_slug
    self.public_slug ||= name.parameterize
  end
end
