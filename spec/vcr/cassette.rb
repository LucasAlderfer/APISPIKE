# require 'rubygems'
# require 'test/unit'
# require 'vcr'
#
# VCR.configure do |config|
#   config.cassette_library_dir = "fixtures/vcr_cassettes"
#   config.hook_into :webmock
# end
#
# class VCRTest < Test::Unit::TestCase
#   def test_home
#     VCR.use_cassette("home") do
#       response = Net::HTTP.get_response(URI('http://localhost:3000/'))
#       assert_match /Example domains/, response.body
#     end
#   end
# end
