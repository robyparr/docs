# frozen_string_literal: true

class ApiTokensController < ApplicationController
  def create
    repository.api_tokens.create! name: 'Unnamed'
    redirect_to repository, notice: 'A new token has been generated.'
  end

  def edit
    @token = repository.api_tokens.find params[:id]
  end

  def update
    @token = repository.api_tokens.find params[:id]
    if @token.update token_params
      redirect_to repository, notice: 'Token updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    token = repository.api_tokens.find params[:id]
    token.destroy!

    redirect_to repository, notice: "Token '#{token.name}' has been deleted."
  end

  private

  def repository
    @repository ||= current_organization.repositories.find params[:repository_id]
  end

  def token_params
    params.require(:api_token).permit(:name)
  end
end
