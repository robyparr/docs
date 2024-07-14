# frozen_string_literal: true

class Public::BaseController < ApplicationController
  layout 'public'

  skip_before_action :authenticate_user!
  before_action :ensure_organization!

  private

  def ensure_organization!
    current_organization
  end

  def current_organization
    @current_organization ||= Organization.find_by! subdomain: request.subdomain
  end

  def repository
    @repository ||= current_organization.repositories.find_by! public: true, public_slug: params[:slug]
  end
end
