# frozen_string_literal: true

class Public::DocumentsController < Public::BaseController
  def show
    @document = repository.documents.find params[:id]
    @documents =
      if @document.file?
        @document.parent&.children || repository.root_documents
      else
        @document.children
      end
    @documents = @documents.to_a.sort_by(&:basename)

    render 'documents/show'
  end
end
