class RepositoriesController < ApplicationController
  helper_method :configs
  helper_method :sort_tags_by
  helper_method :sort_tags_order

  after_action do
    cookies.permanent[:sort_tags_by]    = sort_tags_by
    cookies.permanent[:sort_tags_order] = sort_tags_order
  end

  def index
    @repositories = Repository.list(last: params[:last])
    @namespaces   = Hash[@repositories.group_by(&:namespace).sort]
  end

  def show
    @repository = Repository.find params[:repo]
    @tags       = sort_tags
  end

  private

  def configs
    Rails.application.config.x
  end

  def sort_tags
    tags = @repository.tags
    tags = tags.sort if sort_tags_by == "name"
    tags = VersionSorter.sort(tags) if sort_tags_by == "version"
    tags = tags.reverse if sort_tags_order == "desc"
    tags
  end

  def sort_tags_by
    params[:sort_tags_by] || cookies[:sort_tags_by] || configs.sort_tags_by
  end

  def sort_tags_order
    params[:sort_tags_order] || cookies[:sort_tags_order] || configs.sort_tags_order
  end
end
