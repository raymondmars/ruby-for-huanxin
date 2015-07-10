require 'spec_helper'

describe Huanxin do 
  before(:all) do 
    @cache ||= ActiveSupport::Cache::MemoryStore.new size: 10.megabytes
    @client = Huanxin::Client.new(@cache, ENV['HUANXIN_ORG_NAME'], ENV['HUANXIN_APP_NAME'])
    @username = 'test_001'
    @password = 'test_pwd_001'
    @nickname = '牛叉叉'
  end 

  it 'has a version number' do
    expect(Huanxin::VERSION).not_to be nil
  end

  it 'can register user to huanxin' do 
    username, password = @client.register_by_name_pwd(@username, @password, @nickname)
    expect(username).not_to be nil 
    expect(password).not_to be nil 
    expect(username).to eq(@username)

  end 
  it 'can get a existed user' do 
    rt = @client.get_user(@username)
    expect(rt).not_to be nil 
    expect(rt["username"]).to eq(@username)
    expect(rt["nickname"]).to eq(@nickname)
  end 

  it 'can reset user password' do 
    rt = @client.reset_user_password(@username, 'test_pwd_002')
    expect(rt).not_to be nil 
    expect(rt).to eq('test_pwd_002')
    
  end  

  it 'modify user nickname' do 
    rt = @client.modify_user_nickname(@username, '就是这么牛B')
    expect(rt).not_to be nil 
    expect(rt["username"]).to eq(@username)
    expect(rt["nickname"]).to eq('就是这么牛B')
  end

  it 'can delete a existed user' do 
    rt = @client.delete_user(@username)
    expect(rt).not_to be nil 
    expect(rt["username"]).to eq(@username)
  end

  after(:all) do 
    @client.delete_user(@username)
  end 

end
