require 'httparty'

module Huanxin 

  class Client < Huanxin::Base

    def initialize(cache_client, org_name, app_name)
      super(cache_client, org_name, app_name)

    end
    #注册用户到环信
    def register(user_id, nickname)
      token = self.auth_token()
      username = self.generate_username(user_id)
      password = self.generate_password()

      result = HTTParty.post("#{@head_url}/users", 
          :body => { :username     => self.generate_username(user_id), 
                     :password     => self.generate_password(), 
                     :nickname     => nickname
                   }.to_json,
          :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )
      if result.response.code.to_i == 200
        return [username, password] 
      else
        nil
      end
    end 
    #获取环信上的用户
    def get_user(username)
      token = self.auth_token()
      result = HTTParty.get("#{@head_url}/users/#{username}", :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )
      
      if result.response.code.to_i == 200
        return result["entities"][0] 
      else
        nil
      end

    end
    #删除环信上的用户 
    #
    #

    protected 

    def auth_token
      @cache.fetch( @token_cache_key, expires_in: 6.days ) do 
        cache_val = nil 
        begin
          result = HTTParty.post("#{@head_url}/token", 
              :body => { :grant_type    => 'client_credentials', 
                         :client_id     => @client_id, 
                         :client_secret => @client_secret
                       }.to_json,
              :headers => { 'Content-Type' => 'application/json' } )

          #puts result.inspect
          #puts result.response.code
          
          if !result.nil? and !result["access_token"].blank? 
            cache_val = result["access_token"]
          end 
        rescue => e
          puts e 
        end 

       cache_val

      end
    end  

  end 

end
