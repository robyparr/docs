# frozen_string_literal: true

class DocumentsController < ApplicationController
  def index
    @documents = root_documents
  end

  def show
    @document = current_organization.documents.find params[:id]
    @documents =
      if @document.file?
        @document&.parent&.children || root_documents
      else
        @document.children
      end
    @documents = @documents.to_a.sort_by(&:basename)
  end

  private

  def root_documents
    current_organization.documents.where parent: nil
  end
end
