class HomeController < ApplicationController
  def index
    if current_user
      @followers = session[:followers]
      @name = session[:name]
      @profile_pic = session[:profile_pic]
      @star_number = session[:star_number]
    end
  end
end
