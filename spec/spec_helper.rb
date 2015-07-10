$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'huanxin'
require 'active_support'

Huanxin.configure do |config|
  config[:client_id]     = ENV["HUANXIN_CLIENT_ID"]
  config[:client_secret] = ENV["HUANXIN_CLIENT_SECRET"]
  config[:host]          = 'https://a1.easemob.com'
end 

#run bundle exec rspec spec
