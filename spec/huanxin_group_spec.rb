require 'spec_helper'
#run bundle exec rspec spec 
describe "Huanxin Group" do 
  before(:all) do 
    @client   = HuanxinHelper.client
    @owner = 'amdin_001'
    @nickname = 'admin牛叉叉'
 
    #@client.register_by_name_pwd(@owner, '111111', @nickname)

    @group_name = '大家一起来吐槽'
    @group_desc = '提供一个大家吐槽的地方'
  end 

  it 'can create and modify, delete a group' do 
    @group_id = @client.create_group(@group_name, @group_desc, @owner)
    expect(@group_id).not_to be nil 

    new_group_name = "#{@group_name}_001"

    md = @client.modify_group(@group_id, new_group_name, @group_desc) 
    expect(md).not_to be nil 
    expect(md["groupname"]).to eq(true)

    rt = @client.get_group_info(@group_id)
    expect(rt).not_to be nil 
    expect(rt["name"]).to eq(new_group_name)
    expect(rt["description"]).to eq(@group_desc) 

    gpid, success = @client.delete_group(@group_id) 

    expect(gpid).to eq(@group_id)
    expect(success).to eq(true)

  end 

  after(:all) do 
    #@client.delete_user(@owner)
  end
end
