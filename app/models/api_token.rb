# frozen_string_literal: true

class ApiToken < ApplicationRecord
  TOKEN_LENGTH_CHARS = 36

  belongs_to :repository

  validates :name, presence: true

  after_initialize :set_token

  private

  def set_token
    self.token ||= SecureRandom.base58 TOKEN_LENGTH_CHARS
  end
end
