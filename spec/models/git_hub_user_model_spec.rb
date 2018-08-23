require 'rails_helper'

FactoryBot.find_definitions

describe User do
  it 'exists' do
    user = create(:user)
    expect(user.name).to be_a(String)
    expect(user.uid).to be_a(String)
    expect(user.uid.to_i).to be_a(Integer)
    expect(user.token).to be_a(String)
    expect(user.provider).to be_a(String)
  end
  it 'can be created with omniauth' do
    auth = {'provider' => 'github', 'uid' => '36676968', 'info' => {'nickname' => 'LucasAlderfer'}, 'credentials' => {'token' => ENV['SAMPLE_TOKEN']}}
    user = User.create_with_omniauth(auth)
    expect(user.provider).to eq('github')
    expect(user.uid).to eq('36676968')
    expect(user.name).to eq('LucasAlderfer')
    expect(user.token).to eq(ENV['SAMPLE_TOKEN'])
  end
end

describe GitHubUser do
  it 'exists' do
    user = create(:user)
    githubuser = GitHubUser.new(user)
    expect(githubuser.name).to be_a(String)
    expect(githubuser.name).to eq(user.name)
    expect(githubuser.uid).to be_a(String)
    expect(githubuser.uid.to_i).to be_a(Integer)
    expect(githubuser.uid).to eq(user.uid)
    expect(githubuser.token).to be_a(String)
    expect(githubuser.token).to eq(user.token)
  end

  describe 'instance methods' do
    it 'can find number of starred repos' do
      user = create(:user)
      githubuser = GitHubUser.new(user)
      expect(githubuser.star_number).to be_a(Integer)
      expect(githubuser.followers).to be_a(String)
      expect(githubuser.following).to be_a(String)
      expect(githubuser.recent_activity).to be_a(String)
      expect(githubuser.organizations).to be_a(String)
      expect(githubuser.repos).to be_a(String)
      expect(githubuser.profile_pic_url).to be_a(String)
    end
  end
end
