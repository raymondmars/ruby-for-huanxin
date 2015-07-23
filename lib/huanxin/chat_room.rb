module Huanxin 

  module ChatRoom 
    #创建一个聊天室
    def create_chat_room(name, desc, owner, maxusers = 200, members = nil) 
      token =    self.auth_token()
      body  =    {name: name, description: desc, owner: owner, maxusers: maxusers}
      body.merge!({members: members}) unless members.nil?

      result = HTTParty.post("#{@head_url}/chatrooms", 
          :body => body.to_json,
          :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )

      if result.response.code.to_i == 200
        return result["data"]["id"] 
      else
        nil
      end 
    end 
    #修改聊天室
    def modify_chat_room(room_id, name, desc, maxusers = nil) 
      token =    self.auth_token()
      body  =    {name: name, description: desc} 
      body.merge!({maxusers: maxusers}) unless maxusers.nil?

      result = HTTParty.put("#{@head_url}/chatrooms/#{room_id}", 
          :body => body.to_json,
          :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )

      if result.response.code.to_i == 200
        return result["data"] 
      else
        nil
      end 
    end
    #获取聊天室基本信息 
    def get_chat_room_info(room_id) 
      token =    self.auth_token()

      result = HTTParty.get("#{@head_url}/chatrooms/#{room_id}", 
          :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )

      if result.response.code.to_i == 200
        return result["data"][0] 
      else
        nil
      end 
    end 
    #删除一个聊天室 
    #
    def delete_chat_room(room_id)
      token =    self.auth_token()

      result = HTTParty.delete("#{@head_url}/chatrooms/#{room_id}", 
          :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )

      if result.response.code.to_i == 200
        return [result["data"]["id"], result["data"]["success"]]
      else
        nil
      end 
    end
  end 

end
