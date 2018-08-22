class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    # user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    if auth['provider'] == 'github'
      githubaccount = GitHubAccount.new(auth)
      githubaccount.user_setup
      session[:user_id] = githubaccount.uid
      githubuser = githubaccount.all[0]
      session[:followers] = githubuser.followers
      session[:name] = githubuser.name
      session[:profile_pic] = githubuser.profile_pic_url
      session[:star_number] = githubuser.star_number
      session[:following] = githubuser.following
      session[:recent_activity] = githubuser.recent_activity
    end
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
