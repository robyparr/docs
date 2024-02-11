# frozen_string_literal: true

class Api::BaseController < ActionController::API
  def current_organization
    @current_organization ||= Organization.find_by! subdomain: request.subdomain
  end
end
