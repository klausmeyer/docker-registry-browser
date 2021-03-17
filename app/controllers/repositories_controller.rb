class RepositoriesController < ApplicationController
  helper_method :configs

  def index
    @repositories = Repository.list(last: params[:last])
    @namespaces   = Hash[@repositories.group_by(&:namespace).sort]
  end

  def show
    @repository = Repository.find params[:repo]
  end

  private

  def configs
    Rails.application.config.x
  end
end
