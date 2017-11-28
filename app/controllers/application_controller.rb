class ApplicationController < ActionController::Base
  rescue_from Faraday::ResourceNotFound, with: :render_404

  private

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
