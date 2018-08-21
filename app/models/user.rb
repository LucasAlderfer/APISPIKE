require 'nokogiri'
require 'open-uri'
class User < ApplicationRecord
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.image = auth['extra']['raw_info']['avatar_url']
      user.star_url = auth['extra']['raw_info']['starred_url']
      user.followers = auth['extra']['raw_info']['followers'].to_i
      user.following = auth['extra']['raw_info']['following'].to_i
    end
  end

  def find_star_number
    url = self.star_url[0..-16]
    page = Nokogiri::HTML(open("#{url}"))
    page.children.count - 1
  end
end
