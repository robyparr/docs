# frozen_string_literal: true

module ApplicationHelper
  def component(name, options = {}, &block)
    klass = "#{name.camelcase}Component".constantize
    content = options.delete(:content)

    obj = klass.new(**options)
    obj = obj.with_content(content) if content

    render obj, &block
  end

  def resolve_document_path(repo, doc)
    is_public = request.path.start_with? '/public/'
    return public_document_path(repo.public_slug, doc) if is_public

    repository_document_path repo, doc
  end
end
