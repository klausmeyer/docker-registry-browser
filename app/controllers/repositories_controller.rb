class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find params[:name]
  end

  def tag
    @repository = Repository.find params[:name]
    @tag        = @repository.tag params[:tag]
  end
end
