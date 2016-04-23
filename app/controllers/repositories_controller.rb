class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find params[:repo]
  end
end
