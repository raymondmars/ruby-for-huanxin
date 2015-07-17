module Huanxin 
  @huanxin_config = {}

  class << self
    def configure
      yield @huanxin_config if block_given?
    end
    def config
      @huanxin_config
    end
  end 

  class Base  
    RAND_WORDS  = [('a'..'z'), (0..9), ['_','-']].map { |i| i.to_a }.flatten
    #RAND_WORDS  = [('a'..'z'), ('A'..'Z'), (0..9), ['_']].map { |i| i.to_a }.flatten
    #由于环信聊天接口会强制转换用户名成小写，所以最好不要包括大写字符，已经和他们沟通，他们不会修改.
    #cache_client 所有实现了 ActiveSupport::Cache::Store 的对象实例
    #如果是在rails里面使用，可以直接传递 Rails.cache 
    #
    def initialize(cache_client, org_name, app_name)
      raise 'invalid cache client' if cache_client.nil?

      @client_id       = Huanxin.config[:client_id]
      @client_secret   = Huanxin.config[:client_secret]
      @base_url        = Huanxin.config[:host]         || 'https://a1.easemob.com'
      @username_len    = Huanxin.config[:username_len] || 10
      @password_len    = Huanxin.config[:password_len] || 12

      @org_name        = org_name
      @app_name        = app_name
      @cache           = cache_client

      @head_url        = "#{@base_url}/#{org_name}/#{app_name}"
      @token_cache_key = "_huanxin_auth_#{org_name}_#{app_name}_"
    end 
 
    protected 

    def generate_username(user_id)
      "#{(0...@username_len).map { RAND_WORDS[rand(RAND_WORDS.length)] }.join}n#{user_id}"
    end 
    def generate_password
      "#{(0...@password_len).map { RAND_WORDS[rand(RAND_WORDS.length)] }.join}"
    end 

  end 

end
