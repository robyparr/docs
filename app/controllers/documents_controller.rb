# frozen_string_literal: true

class DocumentsController < ApplicationController
  def show
    @document = repository.documents.find params[:id]
    @documents =
      if @document.file?
        @document.parent&.children || repository.root_documents
      else
        @document.children
      end
    @documents = @documents.to_a.sort_by(&:basename)
  end

  private

  def repository
    @repository ||= current_organization.repositories.find params[:repository_id]
  end
end
