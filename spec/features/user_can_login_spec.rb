require 'rails_helper'

describe 'visiting /' do
  context 'as a visitor' do
    it 'can authenticate through github' do
      stub_omniauth
      json_response_0 = File.open('./fixtures/user.json')
      stub_request(:get, 'https://api.github.com/users/LucasAlderfer').to_return(status: 200, body: json_response_0)

      json_response_1 = File.open('./fixtures/starred_repos.json')
      stub_request(:get, 'https://api.github.com/users/LucasAlderfer/starred').to_return(status: 200, body: json_response_1)

      json_response_2 = File.open('./fixtures/followers.json')
      stub_request(:get, 'https://api.github.com/users/LucasAlderfer/followers').to_return(status: 200, body: json_response_2)

      json_response_3 = File.open('./fixtures/following.json')
      stub_request(:get, 'https://api.github.com/users/LucasAlderfer/following').to_return(status: 200, body: json_response_3)

      json_response_4 = File.open('./fixtures/recent_activity.json')
      stub_request(:get, 'https://api.github.com/users/LucasAlderfer/events').to_return(status: 200, body: json_response_4)

      json_response_5 = File.open('./fixtures/organizations.json')
      stub_request(:get, 'https://api.github.com/users/LucasAlderfer/orgs').to_return(status: 200, body: json_response_5)

      json_response_6 = File.open('./fixtures/repos.json')
      stub_request(:get, 'https://api.github.com/users/LucasAlderfer/repos').to_return(status: 200, body: json_response_6)
      visit '/'

      click_link 'Login with GitHub!'

      expect(page).to have_content("Welcome LucasAlderfer")
      expect(page).to have_content('Followers:')
    end
  end
end
