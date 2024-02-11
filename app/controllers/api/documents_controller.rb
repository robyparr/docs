# frozen_string_literal: true

class Api::DocumentsController < Api::BaseController
  wrap_parameters false

  def create
    ActiveRecord::Base.transaction do
      documents_attrs.each do |attrs|
        path = attrs[:path]
        document = documents_by_path[path] || current_organization.documents.build(path:)

        parent_path = path.split('/')[..-2].join('/')
        attrs[:parent] = documents_by_path[parent_path]

        document.update! attrs
        documents_by_path[path] = document
      end
    end

    head :ok
  end

  private

  def permitted_params
    params.permit documents: %i[path content]
  end

  def documents_attrs
    return @documents_attrs if defined?(@documents_attrs)

    documents_attrs = permitted_params[:documents].map(&:to_h).sort_by { |attrs| attrs[:path] }
    @documents_attrs = documents_attrs
      .flat_map do |attrs|
        segments = attrs[:path].gsub(%r{\Adocs/}, '').split('/')

        current_path = ''
        segments.map.with_index do |segment, index|
          is_file = index == segments.length - 1
          current_path += segment
          current_path += '/' unless is_file

          attrs.merge(
            path: current_path.chomp('/'),
            basename: File.basename(current_path),
            content: is_file ? attrs[:content] : nil
          )
        end
      end
      .uniq
  end

  def documents_by_path
    @documents_by_path ||= begin
      paths = documents_attrs.map { _1[:path] }
      current_organization.documents.where(path: paths).to_a.index_by(&:path)
    end
  end
end
