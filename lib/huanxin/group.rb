module Huanxin 
  module Group 

    #创建一个群组
    def create_group(name, desc, owner, is_public = true, maxusers = 200, is_approval = false, members = nil) 
      token =    self.auth_token()
      body  =    {groupname: name, desc: desc, public: is_public,  owner: owner, maxusers: maxusers, approval: is_approval}
      body.merge!({members: members}) unless members.nil?

      result = HTTParty.post("#{@head_url}/chatgroups", 
          :body => body.to_json,
          :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )


      if result.response.code.to_i == 200
        return result["data"]["groupid"] 
      else
        nil
      end 
    end 
    #修改群组信息
    def modify_group(group_id, name, desc, maxusers = nil) 
      token =    self.auth_token()
      body  =    {groupname: name, description: desc}
      body.merge!({maxusers: maxusers}) unless maxusers.nil?

      result = HTTParty.put("#{@head_url}/chatgroups/#{group_id}", 
          :body => body.to_json,
          :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )


      if result.response.code.to_i == 200
        return result["data"]  #maxusers, groupname, description
      else
        nil
      end 
    end
    #获取群组基本信息 
    def get_group_info(group_id) 
      token =    self.auth_token()

      result = HTTParty.get("#{@head_url}/chatgroups/#{group_id}", 
          :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )

      if result.response.code.to_i == 200
        return result["data"][0] 
      else
        nil
      end 
    end 
    #删除一个群组 
    #
    def delete_group(group_id)
      token =    self.auth_token()

      result = HTTParty.delete("#{@head_url}/chatgroups/#{group_id}", 
          :headers => { 'Content-Type' => 'application/json', 'Authorization'=>"Bearer #{token}" } )

      if result.response.code.to_i == 200
        return [result["data"]["groupid"], result["data"]["success"]]
      else
        nil
      end 
    end

  end 
end
