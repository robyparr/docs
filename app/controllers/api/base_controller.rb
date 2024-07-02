# frozen_string_literal: true

class Api::BaseController < ActionController::API
  before_action :authorize_token!

  private

  def current_organization
    @current_organization ||= Organization.find_by! subdomain: request.subdomain
  end

  def repository
    @repository ||= current_organization.repositories.find params[:repository_id]
  end

  def api_token
    @api_token ||= begin
      token_str = request.headers.fetch('Authorization', '').delete_prefix('Basic ')

      api_token = repository.api_tokens.find_by token: token_str
      api_token&.with_lock { api_token.update! last_used_at: Time.current, usage_count: api_token.usage_count + 1 }
      api_token
    end
  end

  def authorize_token!
    head :unauthorized unless api_token
  end
end
