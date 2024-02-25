# frozen_string_literal: true

class DocumentsController < ApplicationController
  def index
    @documents = current_organization.documents.where parent: nil
  end

  def show
    @document = current_organization.documents.find params[:id]
    @documents = @document.file? ? @document.parent.children : @document.children
    @documents = @documents.sort_by(&:basename)
  end
end
