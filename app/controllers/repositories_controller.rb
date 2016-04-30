class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.list(last: params[:last])
  end

  def show
    @repository = Repository.find params[:repo]
  end
end
