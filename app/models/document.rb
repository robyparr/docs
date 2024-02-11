# frozen_string_literal: true

class Document < ApplicationRecord
  belongs_to :organization
  belongs_to :parent, class_name: 'Document', foreign_key: :parent_id, required: false
  has_many :children, class_name: 'Document', foreign_key: :parent_id
end
