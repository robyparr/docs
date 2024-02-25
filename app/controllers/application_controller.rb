class ApplicationController < ActionController::Base
  layout :set_layout

  before_action :authenticate_user!

  private

  def set_layout
    user_signed_in? ? 'application' : 'guest'
  end

  def current_organization
    @current_organization ||= Organization.find_by! subdomain: request.subdomain
  end
end
