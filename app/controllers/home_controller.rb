class HomeController < ApplicationController
  def index
    @gravatar_urls = User.order("id DESC").limit(80).map do |user|
      user.gravatar_url(size: 50)
    end
  end
end
