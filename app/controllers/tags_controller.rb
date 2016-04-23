class TagsController < ApplicationController
  before_action :find_tag

  def show
  end

  def destroy
    if @tag.delete
      redirect_with_flash :notice, "The tag #{@tag.name} has been deleted."
    else
      redirect_with_flash :error, "The tag #{@tag.name} could not be deleted."
    end
  end

  private

  def find_tag
    @repository = Repository.find params[:repo]
    @tag        = Tag.find(repository: @repository, name: params[:tag])
  end

  def redirect_with_flash(type, message)
    redirect_to repository_path(@repository.name), flash: { type => message }
  end
end