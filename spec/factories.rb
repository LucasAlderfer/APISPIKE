FactoryBot.define do
  factory :user do
    provider { "github" }
    uid  { "36676968" }
    name { 'LucasAlderfer' }
    token { ENV['SAMPLE_TOKEN'] }
  end

  factory :git_hub_user do
    uid  { "36676968" }
    name { 'LucasAlderfer' }
    token { ENV['SAMPLE_TOKEN'] }
  end
end
