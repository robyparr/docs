class ApplicationController < ActionController::Base
  layout :set_layout

  before_action :authenticate_user!

  private

  def set_layout
    user_signed_in? ? 'application' : 'guest'
  end
end
