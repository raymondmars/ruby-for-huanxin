require 'spec_helper'
#run bundle exec rspec spec/huanxin_chatroom_spec.rb
describe "Huanxin Chat Room" do 
  before(:all) do 
    @client   = HuanxinHelper.client
    @owner = 'amdin_001'
    @nickname = 'admin牛叉叉'
 
    #@client.register_by_name_pwd(@owner, '111111', @nickname)

    @chat_name = '大家一起来吐槽'
    @chat_desc = '提供一个大家吐槽的地方'
  end 

  it 'can create and modify, delete a chat room' do 
    @chat_id = @client.create_chat_room(@chat_name, @chat_desc, @owner)
    expect(@chat_id).not_to be nil 

    new_chat_name = "#{@chat_name}_017"

    md = @client.modify_chat_room(@chat_id, new_chat_name, @chat_desc) 
    expect(md).not_to be nil 
    expect(md["name"]).to eq(true)

    rt = @client.get_chat_room_info(@chat_id)
    expect(rt).not_to be nil 
    expect(rt["name"]).to eq(new_chat_name)
    expect(rt["description"]).to eq(@chat_desc) 

    gpid, success = @client.delete_chat_room(@chat_id) 

    expect(gpid).to eq(@chat_id)
    expect(success).to eq(true)
  end  

  after(:all) do 

  end
end
