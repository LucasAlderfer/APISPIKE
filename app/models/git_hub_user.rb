class GitHubUser
  attr_reader :uid, :name, :token

  def initialize(user)
    @uid = user.uid
    @name = user.name
    @token = user.token
  end

  def profile_pic_url
    user_hash['avatar_url']
  end

  def star_number
    url = user_hash['starred_url'][0..-16]
    faraday_setup(url).count
  end

  def followers
    url = user_hash['followers_url']
    follows = faraday_setup(url)
    follower_logins = []
    follows.map do |follower|
      follower_logins << follower['login']
    end
    follower_logins.join(', ')
  end

  def following
    url = user_hash['following_url'][0..-14]
    followings = faraday_setup(url)
    following_logins = []
    followings.map do |follow|
      following_logins << follow['login']
    end
    following_logins.join(', ')
  end

  def recent_activity
    url = user_hash['events_url'][0..-11]
    recent_activities = faraday_setup(url)
    recent = []
    recent_activities.map do |activity|
      string = [activity['type'], activity['repo']['name']]
      recent << string.join(' for repo: ')
    end
    recent[0..4].join(', ')
  end

  def following_activity
    url = user_hash['received_events_url']
    recent_activities = faraday_setup(url)
    binding.pry
  end

  def organizations
    url = user_hash['organizations_url']
    user_organizations = faraday_setup(url)
    orgs = []
    user_organizations.map do |organization|
      string = [organization['name']]
      orgs << string.join(', ')
    end
    orgs.join(', ')
  end

  def repos
    url = user_hash['repos_url']
    repositories = faraday_setup(url)
    repos = []
    repositories.map do |repo|
      string = [repo['name'], repo['updated_at']]
      repos << string.join(', last updated: ')
    end
    repos.join(', ')
  end

  private

  def faraday_setup(url)
    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers['Authorization'] = "token #{@token}"
      faraday.adapter Faraday.default_adapter
    end
    JSON.parse(conn.get(url).body)
  end

  def user_hash
    faraday_setup("/users/#{@name}")
  end
end
