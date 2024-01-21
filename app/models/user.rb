class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :lockable,
         :trackable

  belongs_to :organization

  before_validation :create_organization

  private

  def create_organization
    return if organization_id

    build_organization name: email.split('@').first
  end
end
