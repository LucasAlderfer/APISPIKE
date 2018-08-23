class HomeController < ApplicationController

  def index
    if current_user && @current_user.provider == 'github'
      @githubuser = GitHubUser.new(@current_user)
    end
  end
  
end
