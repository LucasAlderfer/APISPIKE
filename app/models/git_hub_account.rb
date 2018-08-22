class GitHubAccount
  attr_reader :provider, :uid, :name, :token, :all

  def initialize(auth)
    @uid = auth["uid"]
    @name = auth['extra']['raw_info']['login']
    @token = auth['credentials']['token']
    @all = []
  end

  def user_setup
    page = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers['Authorization'] = "token #{@token}"
      faraday.adapter Faraday.default_adapter
    end
    response = page.get("/users/#{self.name}")
    hash = JSON.parse(response.body)
    profile_pic_url = hash['avatar_url']
    starred_url = hash['starred_url'][0..-16]
    followers_url = hash['followers_url']
    following_url = hash['following_url'][0..-14]
    recent_commits_url = hash['events_url'][0..-11]
    followers_commits_url = hash['received_events_url']
    organizations_url = hash['organizations_url']
    repos_url = hash['repos_url']
    user_hash = [profile_pic_url, starred_url, followers_url, following_url, recent_commits_url, followers_commits_url, organizations_url, repos_url]
    new_user = GitHubUser.new(@uid, @name, @token, user_hash)
    new_user.star_number
    new_user.followers
    new_user.following
    new_user.recent_activity
    @all << new_user
  end
end
