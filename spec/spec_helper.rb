$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'huanxin'
require 'active_support'

Huanxin.configure do |config|
  config[:client_id]     = ENV["HUANXIN_CLIENT_ID"]
  config[:client_secret] = ENV["HUANXIN_CLIENT_SECRET"]
  config[:host]          = 'https://a1.easemob.com'
end 

class HuanxinHelper
  @cache ||= ActiveSupport::Cache::MemoryStore.new size: 10.megabytes
  def self.cache 
    @cache
  end 
  def self.client 
    Huanxin::Client.new(@cache, ENV['HUANXIN_ORG_NAME'], ENV['HUANXIN_APP_NAME'])
  end
end
#run bundle exec rspec spec
