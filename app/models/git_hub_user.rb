class GitHubUser
  attr_reader :profile_pic_url, :uid, :name, :star_number, :followers

  def initialize(uid, name, token, url_hash)
    @uid = uid
    @name = name
    @token = token
    @url_hash = url_hash
    @star_number = 0
    @profile_pic_url = url_hash[0]
    @followers = []
    # @starred_url = url_hash[1]
    # @followers_url = url_hash[2]
    # @following_url = url_hash[3]
    # @recent_commits_url = url_hash[4]
    # @followers_commits_url = url_hash[5]
    # @organizations_url = url_hash[6]
    # @repos_url = url_hash[7]
  end

  def faraday_steup
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers['Authorization'] = "token #{@token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def star_number
    response = faraday_steup.get("#{@url_hash[1]}")
    @star_number = JSON.parse(response.body).count
  end

  def followers
    response = faraday_steup.get("#{@url_hash[2]}")
    @star_number = JSON.parse(response.body)
    follower_logins = []
    @star_number.map do |follower|
      follower_logins << follower['login']
    end
    @followers = follower_logins.join(', ')
  end

  # def following
  #
  # end

end
