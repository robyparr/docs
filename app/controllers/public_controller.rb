# frozen_string_literal: true

class PublicController < Public::BaseController
  def show
    @repository = repository
    render :show
  end
end
