# frozen_string_literal: true

class Document < ApplicationRecord
  belongs_to :organization
  belongs_to :repository
  belongs_to :parent, class_name: 'Document', foreign_key: :parent_id, required: false

  has_many :children, class_name: 'Document', foreign_key: :parent_id

  def file?
    content.present?
  end

  def render_content_toc
    MarkdownRenderer.instance.render_table_of_contents content
  end

  def render_content
    MarkdownRenderer.instance.render content
  end
end
