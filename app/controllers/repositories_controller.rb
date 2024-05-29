# frozen_string_literal: true

class RepositoriesController < ApplicationController
  def index
    @repositories = current_organization.repositories
  end

  def show
    @repository = current_organization.repositories.find params[:id]
  end

  def new
    @repository = Repository.new
  end

  def edit
    @repository = current_organization.repositories.find params[:id]
  end

  def create
    @repository = current_organization.repositories.build repository_params
    @repository.user = current_user

    if @repository.save
      redirect_to repository_url(@repository), notice: 'Repository was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @repository = current_organization.repositories.find params[:id]

    if @repository.update(repository_params)
      redirect_to repository_url(@repository), notice: 'Repository was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repository = current_organization.repositories.find params[:id]
    @repository.destroy!

    redirect_to repositories_url, notice: 'Repository was successfully destroyed.'
  end

  private

  def repository_params
    params.require(:repository).permit(:name)
  end
end
